class OeInputSpacer {
  OeInputSpacer({
    this.iconLabelSpace,
    this.labelInputSpace,
    this.inputRightSpace,
    this.rightSpace,
    this.additionInfoSpace,
  });

  double? iconLabelSpace;
  double? labelInputSpace;
  double? inputRightSpace;
  double? rightSpace;
  double? additionInfoSpace;

  OeInputSpacer.generateDefault() {
    iconLabelSpace = 4;
    labelInputSpace = 16;
    inputRightSpace = 16;
    rightSpace = 16;
    additionInfoSpace = 16;
  }
}
