                import 'dart:html';
          import 'package:manim_web/display/abstract_html_display.dart';
        
      
import 'package:manim_web/manim.dart';

class GaussianScene extends Scene {
  @override
  FutureOr<void> preload() {
    MathTex.preload(r'Iteration: ');
  }

  @override
  Future construct() async {

  }
}

      void main(){
        SingleStringMathTex.texToSVGMap[r'''align*'''] = {};

SingleStringMathTex.texToSVGMap[r'''align*''']![r'''Iteration: '''] = r'''<?xml version='1.0' encoding='UTF-8'?>
<!-- This file was generated by dvisvgm 2.13.3 -->
<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='46.808992pt' height='6.807795pt' viewBox='148.451075 -6.807795 46.808992 6.807795'>
<defs>
<path id='g1-58' d='M1.912827-3.765878C1.912827-4.054795 1.673724-4.293898 1.384807-4.293898S.856787-4.054795 .856787-3.765878S1.09589-3.237858 1.384807-3.237858S1.912827-3.476961 1.912827-3.765878ZM1.912827-.52802C1.912827-.816936 1.673724-1.05604 1.384807-1.05604S.856787-.816936 .856787-.52802S1.09589 0 1.384807 0S1.912827-.239103 1.912827-.52802Z'/>
<path id='g0-73' d='M3.327522-.18929C3.327522-.308842 3.247821-.308842 3.028643-.308842C2.849315-.308842 2.799502-.308842 2.600249-.328767C2.391034-.348692 2.351183-.388543 2.351183-.498132C2.351183-.577833 2.371108-.657534 2.391034-.727273L3.726027-6.03736C3.815691-6.396015 3.845579-6.495641 4.632628-6.495641C4.871731-6.495641 4.951432-6.495641 4.951432-6.684932C4.951432-6.804483 4.841843-6.804483 4.801993-6.804483L3.486924-6.774595L2.161893-6.804483C2.092154-6.804483 1.96264-6.804483 1.96264-6.60523C1.96264-6.495641 2.052304-6.495641 2.241594-6.495641C2.660025-6.495641 2.929016-6.495641 2.929016-6.306351C2.929016-6.256538 2.929016-6.236613 2.909091-6.146949L1.564134-.777086C1.474471-.408468 1.444583-.308842 .657534-.308842C.428394-.308842 .33873-.308842 .33873-.109589C.33873 0 .458281 0 .488169 0L1.793275-.029888L3.128269 0C3.20797 0 3.327522 0 3.327522-.18929Z'/>
<path id='g0-97' d='M4.961395-1.424658C4.961395-1.524284 4.871731-1.524284 4.841843-1.524284C4.742217-1.524284 4.732254-1.484433 4.702366-1.344956C4.533001-.697385 4.353674-.109589 3.945205-.109589C3.676214-.109589 3.646326-.368618 3.646326-.56787C3.646326-.787049 3.666252-.86675 3.775841-1.305106L3.995019-2.201743L4.353674-3.596513C4.423412-3.875467 4.423412-3.895392 4.423412-3.935243C4.423412-4.104608 4.303861-4.204234 4.134496-4.204234C3.895392-4.204234 3.745953-3.985056 3.716065-3.765878C3.536737-4.134496 3.247821-4.403487 2.799502-4.403487C1.633873-4.403487 .398506-2.938979 .398506-1.484433C.398506-.547945 .946451 .109589 1.723537 .109589C1.92279 .109589 2.420922 .069738 3.01868-.637609C3.098381-.219178 3.447073 .109589 3.92528 .109589C4.273973 .109589 4.503113-.119552 4.662516-.438356C4.83188-.797011 4.961395-1.424658 4.961395-1.424658ZM3.566625-3.138232L3.068493-1.185554C3.01868-1.006227 3.01868-.986301 2.86924-.816936C2.430884-.268991 2.022416-.109589 1.743462-.109589C1.24533-.109589 1.105853-.657534 1.105853-1.046077C1.105853-1.544209 1.424658-2.769614 1.653798-3.227895C1.96264-3.815691 2.410959-4.184309 2.809465-4.184309C3.457036-4.184309 3.596513-3.367372 3.596513-3.307597S3.576588-3.188045 3.566625-3.138232Z'/>
<path id='g0-101' d='M4.283935-1.066002C4.283935-1.125778 4.224159-1.195517 4.164384-1.195517C4.11457-1.195517 4.094645-1.175592 4.034869-1.09589C3.247821-.109589 2.161893-.109589 2.042341-.109589C1.265255-.109589 1.175592-.946451 1.175592-1.265255C1.175592-1.384807 1.185554-1.693649 1.334994-2.30137H1.863014C2.15193-2.30137 2.889166-2.321295 3.387298-2.530511C4.084682-2.82939 4.134496-3.417186 4.134496-3.556663C4.134496-3.995019 3.755915-4.403487 3.068493-4.403487C1.96264-4.403487 .458281-3.437111 .458281-1.693649C.458281-.67746 1.046077 .109589 2.022416 .109589C3.447073 .109589 4.283935-.946451 4.283935-1.066002ZM3.805729-3.556663C3.805729-2.520548 2.211706-2.520548 1.803238-2.520548H1.39477C1.783313-4.034869 2.809465-4.184309 3.068493-4.184309C3.536737-4.184309 3.805729-3.895392 3.805729-3.556663Z'/>
<path id='g0-105' d='M2.82939-6.22665C2.82939-6.425903 2.689913-6.585305 2.460772-6.585305C2.191781-6.585305 1.92279-6.326276 1.92279-6.057285C1.92279-5.867995 2.062267-5.69863 2.30137-5.69863C2.530511-5.69863 2.82939-5.927771 2.82939-6.22665ZM2.919054-1.424658C2.919054-1.524284 2.82939-1.524284 2.799502-1.524284C2.699875-1.524284 2.699875-1.494396 2.650062-1.344956C2.470735-.71731 2.141968-.109589 1.633873-.109589C1.464508-.109589 1.39477-.209215 1.39477-.438356C1.39477-.687422 1.454545-.826899 1.683686-1.43462L2.072229-2.480697C2.191781-2.769614 2.191781-2.789539 2.291407-3.058531C2.371108-3.257783 2.420922-3.39726 2.420922-3.58655C2.420922-4.034869 2.102117-4.403487 1.603985-4.403487C.667497-4.403487 .288917-2.958904 .288917-2.86924C.288917-2.769614 .408468-2.769614 .408468-2.769614C.508095-2.769614 .518057-2.789539 .56787-2.948941C.836862-3.88543 1.235367-4.184309 1.574097-4.184309C1.653798-4.184309 1.823163-4.184309 1.823163-3.865504C1.823163-3.656289 1.753425-3.447073 1.713574-3.347447C1.633873-3.088418 1.185554-1.932752 1.026152-1.504359C.926526-1.24533 .797011-.916563 .797011-.707347C.797011-.239103 1.135741 .109589 1.613948 .109589C2.550436 .109589 2.919054-1.334994 2.919054-1.424658Z'/>
<path id='g0-110' d='M5.688667-1.424658C5.688667-1.524284 5.599004-1.524284 5.569116-1.524284C5.469489-1.524284 5.469489-1.494396 5.419676-1.344956C5.220423-.667497 4.891656-.109589 4.403487-.109589C4.234122-.109589 4.164384-.209215 4.164384-.438356C4.164384-.687422 4.254047-.926526 4.343711-1.145704C4.533001-1.673724 4.951432-2.769614 4.951432-3.337484C4.951432-4.004981 4.523039-4.403487 3.805729-4.403487C2.909091-4.403487 2.420922-3.765878 2.251557-3.536737C2.201743-4.094645 1.793275-4.403487 1.334994-4.403487S.687422-4.014944 .587796-3.835616C.428394-3.496887 .288917-2.909091 .288917-2.86924C.288917-2.769614 .408468-2.769614 .408468-2.769614C.508095-2.769614 .518057-2.779577 .577833-2.998755C.747198-3.706102 .946451-4.184309 1.305106-4.184309C1.504359-4.184309 1.613948-4.054795 1.613948-3.726027C1.613948-3.516812 1.58406-3.407223 1.454545-2.889166L.876712-.587796C.846824-.438356 .787049-.209215 .787049-.159402C.787049 .019925 .926526 .109589 1.075965 .109589C1.195517 .109589 1.374844 .029888 1.444583-.169365C1.454545-.18929 1.574097-.657534 1.633873-.9066L1.853051-1.803238C1.912827-2.022416 1.972603-2.241594 2.022416-2.470735L2.15193-2.968867C2.30137-3.277709 2.82939-4.184309 3.775841-4.184309C4.224159-4.184309 4.313823-3.815691 4.313823-3.486924C4.313823-2.86924 3.825654-1.594022 3.666252-1.165629C3.576588-.936488 3.566625-.816936 3.566625-.707347C3.566625-.239103 3.915318 .109589 4.383562 .109589C5.32005 .109589 5.688667-1.344956 5.688667-1.424658Z'/>
<path id='g0-111' d='M4.672478-2.719801C4.672478-3.755915 3.975093-4.403487 3.078456-4.403487C1.743462-4.403487 .408468-2.988792 .408468-1.574097C.408468-.587796 1.075965 .109589 2.002491 .109589C3.327522 .109589 4.672478-1.265255 4.672478-2.719801ZM3.945205-3.108344C3.945205-2.719801 3.745953-1.673724 3.367372-1.026152C3.01868-.448319 2.470735-.109589 2.012453-.109589C1.58406-.109589 1.145704-.418431 1.145704-1.195517C1.145704-1.683686 1.404732-2.759651 1.723537-3.267746C2.221669-4.034869 2.789539-4.184309 3.068493-4.184309C3.646326-4.184309 3.945205-3.706102 3.945205-3.108344Z'/>
<path id='g0-114' d='M4.343711-3.755915C4.343711-4.104608 4.024907-4.403487 3.516812-4.403487C2.86924-4.403487 2.430884-3.915318 2.241594-3.636364C2.161893-4.084682 1.803238-4.403487 1.334994-4.403487C.876712-4.403487 .687422-4.014944 .597758-3.835616C.418431-3.496887 .288917-2.899128 .288917-2.86924C.288917-2.769614 .408468-2.769614 .408468-2.769614C.508095-2.769614 .518057-2.779577 .577833-2.998755C.747198-3.706102 .946451-4.184309 1.305106-4.184309C1.474471-4.184309 1.613948-4.104608 1.613948-3.726027C1.613948-3.516812 1.58406-3.407223 1.454545-2.889166L.876712-.587796C.846824-.438356 .787049-.209215 .787049-.159402C.787049 .019925 .926526 .109589 1.075965 .109589C1.195517 .109589 1.374844 .029888 1.444583-.169365C1.464508-.209215 1.803238-1.564134 1.843088-1.743462L2.161893-3.038605C2.201743-3.16812 2.480697-3.636364 2.719801-3.855542C2.799502-3.92528 3.088418-4.184309 3.516812-4.184309C3.775841-4.184309 3.935243-4.064757 3.935243-4.064757C3.636364-4.014944 3.417186-3.775841 3.417186-3.516812C3.417186-3.35741 3.526775-3.16812 3.795766-3.16812S4.343711-3.39726 4.343711-3.755915Z'/>
<path id='g0-116' d='M3.128269-1.424658C3.128269-1.524284 3.048568-1.524284 3.008717-1.524284C2.919054-1.524284 2.909091-1.494396 2.859278-1.384807C2.430884-.348692 1.902864-.109589 1.564134-.109589C1.354919-.109589 1.255293-.239103 1.255293-.56787C1.255293-.806974 1.275218-.876712 1.315068-1.046077L2.052304-3.985056H2.988792C3.188045-3.985056 3.287671-3.985056 3.287671-4.184309C3.287671-4.293898 3.188045-4.293898 3.008717-4.293898H2.132005C2.49066-5.708593 2.540473-5.907846 2.540473-5.967621C2.540473-6.136986 2.420922-6.236613 2.251557-6.236613C2.221669-6.236613 1.942715-6.22665 1.853051-5.877958L1.464508-4.293898H.52802C.328767-4.293898 .229141-4.293898 .229141-4.104608C.229141-3.985056 .308842-3.985056 .508095-3.985056H1.384807C.667497-1.155666 .627646-.986301 .627646-.806974C.627646-.268991 1.006227 .109589 1.544209 .109589C2.560399 .109589 3.128269-1.344956 3.128269-1.424658Z'/>
</defs>
<g id='page1'>
<use x='148.451075' y='0' xlink:href='#g0-73'/>
<use x='153.612267' y='0' xlink:href='#g0-116'/>
<use x='157.209901' y='0' xlink:href='#g0-101'/>
<use x='161.848773' y='0' xlink:href='#g0-114'/>
<use x='166.620261' y='0' xlink:href='#g0-97'/>
<use x='171.886415' y='0' xlink:href='#g0-116'/>
<use x='175.484049' y='0' xlink:href='#g0-105'/>
<use x='178.916308' y='0' xlink:href='#g0-111'/>
<use x='183.74543' y='0' xlink:href='#g0-110'/>
<use x='192.492687' y='0' xlink:href='#g1-58'/>
</g>
</svg>''';


        var display = Canvas2DDisplay(document.getElementById('canvas-container')!);
        var scene = GaussianScene()..bindDisplay(display);

        scene.run();
      }
    