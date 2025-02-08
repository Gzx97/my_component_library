import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../my_component_library.dart';

enum OeUploadMediaType {
  image, // 图片
  video, // 视频
}

enum OeUploadValidatorError {
  overSize, // 超出文件大小
  overQuantity, // 超出文件数量限制
}

enum OeUploadFileStatus {
  success, // 成功
  loading, // 加载中
  error, // 失败
  retry, // 重试
}

enum OeUploadType {
  add, // 添加
  remove, // 删除
}

class OeUploadFile {
  OeUploadFile(
      {required this.key,
      this.remotePath,
      this.assetPath,
      this.file,
      this.progress,
      this.status = OeUploadFileStatus.success,
      this.loadingText = 'Loading...',
      this.retryText = 'Re-Upload',
      this.errorText = 'Error',
      this.canDelete = true});

  final int key;
  final String? remotePath;
  final String? assetPath;
  final File? file;
  final bool canDelete;
  final int? progress;
  final String loadingText;
  final String retryText;
  final String errorText;
  OeUploadFileStatus status;
}

typedef OeUploadErrorEvent = void Function(Object e);
typedef OeUploadClickEvent = void Function(int value);
typedef OeUploadValueChangedEvent = void Function(
    List<OeUploadFile> files, OeUploadType type);
typedef OeUploadValidatorEvent = void Function(OeUploadValidatorError e);

class OeUpload extends StatefulWidget {
  const OeUpload(
      {Key? key,
      this.max = 0,
      this.mediaType = const [OeUploadMediaType.image, OeUploadMediaType.video],
      this.sizeLimit,
      this.onCancel,
      this.onError,
      this.onValidate,
      this.onClick,
      required this.files,
      this.onChange,
      this.multiple = false})
      : super(key: key);

  /// 控制展示的文件列表
  final List<OeUploadFile> files;

  /// 用于控制文件上传数量，0为不限制，仅在multiple为true时有效
  final int max;

  /// 支持上传的文件类型，图片或视频
  final List<OeUploadMediaType> mediaType;

  /// 图片大小限制，单位为KB
  final double? sizeLimit;

  /// 是否多选上传，默认false
  final bool multiple;

  /// 监听取消上传
  final VoidCallback? onCancel;

  /// 监听获取资源错误
  final OeUploadErrorEvent? onError;

  /// 监听文件校验出错
  final OeUploadValidatorEvent? onValidate;

  /// 监听点击图片位
  final OeUploadClickEvent? onClick;

  /// 监听添加或删除照片
  final OeUploadValueChangedEvent? onChange;

  @override
  State<OeUpload> createState() => _OeUploadState();
}

class _OeUploadState extends State<OeUpload> {
  List<OeUploadFile> fileList = [];

  bool get canUpload => widget.multiple
      ? (widget.max == 0 ? true : fileList.length < widget.max)
      : fileList.isEmpty;
  final ImagePicker _picker = ImagePicker();

  @override
  initState() {
    super.initState();
    fileList = widget.files;
  }

  // 获取相册照片或视频
  Future<List<XFile>> getMediaFromPicker() async {
    if (!canUpload || widget.mediaType.isEmpty) {
      return [];
    }

    List<XFile> medias;

    try {
      if (widget.multiple) {
        if (widget.mediaType.length == 1 &&
            widget.mediaType.contains(OeUploadMediaType.image)) {
          medias = await _picker.pickMultiImage();
        } else {
          medias = await _picker.pickMultiImage();
        }

        return medias;
      }

      XFile? media;
      if (widget.mediaType.length == 1) {
        if (widget.mediaType.contains(OeUploadMediaType.image)) {
          media = await _picker.pickImage(source: ImageSource.gallery);
        } else {
          media = await _picker.pickVideo(source: ImageSource.gallery);
        }
      } else {
        media = await _picker.pickImage(source: ImageSource.gallery);
      }

      return media == null ? [] : [media];
    } on PlatformException catch (e) {
      if (e.code == 'null-error' && widget.onCancel != null) {
        widget.onCancel!();
      } else {
        if (widget.onError != null) {
          widget.onError!(e);
        }
      }
    } catch (e) {
      if (widget.onError != null) {
        widget.onError!(e);
      }
    }

    return [];
  }

  // 处理获取到的资源
  void extractImageList(List<XFile> files) async {
    if (!canUpload || files.isEmpty) {
      return;
    }

    var result = await validateResources(files);

    if (result != null) {
      if (widget.onValidate != null) {
        widget.onValidate!(result);
      }
      return;
    }

    var originMaxKeys =
        fileList.isEmpty ? 0 : fileList.map((file) => file.key).reduce(max);

    var newFiles = <OeUploadFile>[];
    for (var i = 0; i < files.length; i++) {
      newFiles.add(OeUploadFile(
          key: originMaxKeys + i + 1,
          file: File(files[i].path),
          assetPath: files[i].path));
    }

    if (widget.onChange != null) {
      widget.onChange!(newFiles, OeUploadType.add);
    }
  }

  // 校验资源
  Future<OeUploadValidatorError?> validateResources(List<XFile> files) async {
    OeUploadValidatorError? error;

    if (widget.multiple && widget.max > 0) {
      var remain = widget.max - fileList.length;

      if (files.length > remain) {
        error = OeUploadValidatorError.overQuantity;
        return error;
      }
    }

    for (var file in files) {
      if (widget.sizeLimit != null) {
        var fileSize = (await file.length()) * 1024;

        if (fileSize > widget.sizeLimit!) {
          error = OeUploadValidatorError.overSize;
          break;
        }
      }
    }

    return error;
  }

  // 删除资源
  void onDelete(OeUploadFile file) {
    if (widget.onChange != null) {
      widget.onChange!([file], OeUploadType.remove);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 8,
        runSpacing: 16,
        children: [
          ...fileList.map((file) => _buildImageBox(context, file)).toList(),
          _buildUploadBox(context, shouldDisplay: canUpload, onTap: () async {
            final files = await getMediaFromPicker();
            extractImageList(files);
          }),
        ],
      ),
    );
  }

  Widget _buildUploadBox(BuildContext context,
      {void Function()? onTap, bool shouldDisplay = true}) {
    return Visibility(
        visible: shouldDisplay,
        child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: OeTheme.of(context).grayColor1,
                  borderRadius: BorderRadius.circular(6)),
              child: const Center(
                  child: Icon(
                OeIcons.add,
                color: Color.fromRGBO(0, 0, 0, 0.4),
                size: 28,
              )),
            )));
  }

  Widget _buildImageBox(BuildContext context, OeUploadFile file) {
    return GestureDetector(
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!(file.key);
        }
      },
      child: Stack(
        children: [
          OeImage(
            width: 80,
            height: 80,
            imgUrl: file.remotePath,
            // assetUrl: file.assetPath,
            imageFile: file.file,
          ),
          Visibility(
              visible: file.status != OeUploadFileStatus.success,
              child: _buildShadowBox(file)),
          Visibility(
              visible: file.canDelete,
              child: Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      onDelete(file);
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              topRight: Radius.circular(6))),
                      child: const Center(
                          child: Icon(
                        OeIcons.close,
                        size: 16,
                        color: Colors.white,
                      )),
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _buildShadowBox(OeUploadFile file) {
    var displayText = '';
    switch (file.status) {
      case OeUploadFileStatus.loading:
        displayText =
            file.progress != null ? '${file.progress!}%' : file.loadingText;
        break;
      case OeUploadFileStatus.retry:
        displayText = file.retryText;
        break;
      case OeUploadFileStatus.error:
        displayText = file.errorText;
        break;
      default:
    }

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: file.status == OeUploadFileStatus.loading,
                child: const OeLoading(
                  size: OeLoadingSize.large,
                  icon: OeLoadingIcon.circle,
                  iconColor: Colors.white,
                ),
              ),
              Visibility(
                  visible: file.status == OeUploadFileStatus.retry ||
                      file.status == OeUploadFileStatus.error,
                  child: Icon(
                    file.status == OeUploadFileStatus.retry
                        ? OeIcons.refresh
                        : OeIcons.close_circle,
                    size: 24,
                    color: Colors.white,
                  )),
              OeText(
                displayText,
                textColor: Colors.white,
                style: const TextStyle(fontSize: 12, height: 1.67),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
