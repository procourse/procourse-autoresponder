import {
  default as computed,
  observes,
  on
} from "ember-addons/ember-computed-decorators";

export default Ember.Component.extend({
  inputTime: null,
  utcTime: null,

  @on("didInsertElement")
  setInputTime(){
    this.set('inputTime',this.get('utcTime'));
  },

  @observes("inputTime")
  timeChanged(){
    this.set('utcTime',this.get('inputTime'));
  },
});
