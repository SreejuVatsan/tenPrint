/**
 * BeatListener is used as a helper class and used along with BeatDetect object.
 * Code from Minim library's FrequencyEnergyBeatDetection example under Analysis section.
 * http://code.compartmental.net/minim/beatdetect_field_freq_energy.html
 */
class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;
  
  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }
  
  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }
  
  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}