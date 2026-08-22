class JourneyTracker {
  bool? estimateSummary;
  bool? finalAssessmentSummary;

  JourneyTracker({
    this.estimateSummary,
    this.finalAssessmentSummary,
  });

  JourneyTracker.fromJson(Map<String, dynamic> json) {
    estimateSummary = json['estimateSummary'];
    finalAssessmentSummary = json['finalAssessmentSummary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estimateSummary'] = estimateSummary;
    data['finalAssessmentSummary'] = finalAssessmentSummary;
    return data;
  }
}

//finalAssessmentSummary
