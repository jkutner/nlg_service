require 'test_helper'

class Api::RealiserControllerTest < ActionController::TestCase

  setup do
    @appositive_payload = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n" +
      "<NLGSpec xmlns=\"http://simplenlg.googlecode.com/svn/trunk/res/xml\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\r\n" +
      "  <Recording name=\"Clause tests\">\r\n" +
      "    <Record name=\"Negation on VP\">\r\n" +
      "      <Document cat=\"PARAGRAPH\">\r\n" +
      "        <child xsi:type=\"SPhraseSpec\" PASSIVE=\"true\">\r\n" +
      "          <vp xsi:type=\"VPPhraseSpec\" TENSE=\"PAST\">\r\n" +
      "            <compl xsi:type=\"NPPhraseSpec\">\r\n" +
      "              <postMod xsi:type=\"NPPhraseSpec\" appositive=\"true\">\r\n" +
      "                <head cat=\"NOUN\">\r\n" +
      "                  <base>D701000000992</base>\r\n" +
      "                </head>\r\n" +
      "                <spec xsi:type=\"WordElement\" cat=\"DETERMINER\">\r\n" +
      "                  <base>the</base>\r\n" +
      "                </spec>\r\n" +
      "              </postMod>\r\n" +
      "              <head cat=\"NOUN\">\r\n" +
      "                <base>angioplasty balloon catheter</base>\r\n" +
      "              </head>\r\n" +
      "              <spec xsi:type=\"WordElement\" cat=\"DETERMINER\">\r\n" +
      "                <base>a</base>\r\n" +
      "              </spec>\r\n" +
      "            </compl>\r\n" +
      "            <head cat=\"VERB\">\r\n" +
      "              <base>deploy</base>\r\n" +
      "            </head>\r\n" +
      "          </vp>\r\n" +
      "        </child>\r\n" +
      "      </Document>\r\n" +
      "      <Realisation>An angioplasty balloon catheter, the D701000000992 was deployed.</Realisation>\r\n" +
      "    </Record>\r\n" +
      "  </Recording>\r\n" +
      "</NLGSpec>\r\n"


    @a_problem_payload = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><NLGSpec xmlns=\"http://simplenlg.googlecode.com/svn/trunk/res/xml\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\r\n" +
      "  <Recording name=\"\">\r\n" +
      "    <Record name=\"\">\r\n" +
      "      <Document>\r\n" +
      "        <child xsi:type=\"SPhraseSpec\">\r\n" +
      "          <subj xsi:type=\"NPPhraseSpec\">\r\n" +
      "            <head cat=\"ADVERB\">\r\n" +
      "              <base>there</base>\r\n" +
      "            </head>\r\n" +
      "          </subj>\r\n" +
      "          <vp xsi:type=\"VPPhraseSpec\">\r\n" +
      "            <compl xsi:type=\"NPPhraseSpec\">\r\n" +
      "              <preMod xsi:type=\"CoordinatedPhraseElement\" conj=\",\">\r\n" +
      "                <coord xsi:type=\"AdjPhraseSpec\">\r\n" +
      "                  <head cat=\"ADJECTIVE\">\r\n" +
      "                    <base>eccentric</base>\r\n" +
      "                  </head>\r\n" +
      "                </coord>\r\n" +
      "                <coord xsi:type=\"AdjPhraseSpec\">\r\n" +
      "                  <head cat=\"ADJECTIVE\">\r\n" +
      "                    <base>tubular</base>\r\n" +
      "                  </head>\r\n" +
      "                </coord>\r\n" +
      "              </preMod>\r\n" +
      "              <head cat=\"NOUN\">\r\n" +
      "                <base>stenosis</base>\r\n" +
      "              </head>\r\n" +
      "              <spec xsi:type=\"WordElement\" cat=\"DETERMINER\">\r\n" +
      "                <base>a</base>\r\n" +
      "              </spec>\r\n" +
      "            </compl>\r\n" +
      "            <postMod xsi:type=\"PPPhraseSpec\">\r\n" +
      "              <compl xsi:type=\"NPPhraseSpec\">\r\n" +
      "                <head cat=\"NOUN\">\r\n" +
      "                  <base>third obtuse marginal branch</base>\r\n" +
      "                </head>\r\n" +
      "                <spec xsi:type=\"WordElement\" cat=\"DETERMINER\">\r\n" +
      "                  <base>the</base>\r\n" +
      "                </spec>\r\n" +
      "              </compl>\r\n" +
      "              <head cat=\"PREPOSITION\">\r\n" +
      "                <base>in</base>\r\n" +
      "              </head>\r\n" +
      "            </postMod>\r\n" +
      "            <head cat=\"VERB\">\r\n" +
      "              <base>be</base>\r\n" +
      "            </head>\r\n" +
      "          </vp>\r\n" +
      "        </child>\r\n" +
      "        <child xsi:type=\"SPhraseSpec\">\r\n" +
      "          <subj xsi:type=\"NPPhraseSpec\">\r\n" +
      "            <head cat=\"ADVERB\">\r\n" +
      "              <base>there</base>\r\n" +
      "            </head>\r\n" +
      "          </subj>\r\n" +
      "          <vp xsi:type=\"VPPhraseSpec\">\r\n" +
      "            <compl xsi:type=\"NPPhraseSpec\">\r\n" +
      "              <preMod xsi:type=\"StringElement\">\r\n" +
      "                <val>80 %</val>\r\n" +
      "              </preMod>\r\n" +
      "              <head cat=\"NOUN\">\r\n" +
      "                <base>stenosis</base>\r\n" +
      "              </head>\r\n" +
      "              <spec xsi:type=\"StringElement\">\r\n" +
      "                <val>an</val>\r\n" +
      "              </spec>\r\n" +
      "            </compl>\r\n" +
      "            <postMod xsi:type=\"PPPhraseSpec\">\r\n" +
      "              <compl xsi:type=\"NPPhraseSpec\">\r\n" +
      "                <preMod xsi:type=\"AdjPhraseSpec\">\r\n" +
      "                  <head cat=\"ADJECTIVE\">\r\n" +
      "                    <base>proximal</base>\r\n" +
      "                  </head>\r\n" +
      "                </preMod>\r\n" +
      "                <head cat=\"NOUN\">\r\n" +
      "                  <base>right coronary artery</base>\r\n" +
      "                </head>\r\n" +
      "                <spec xsi:type=\"WordElement\" cat=\"DETERMINER\">\r\n" +
      "                  <base>the</base>\r\n" +
      "                </spec>\r\n" +
      "              </compl>\r\n" +
      "              <head cat=\"PREPOSITION\">\r\n" +
      "                <base>in</base>\r\n" +
      "              </head>\r\n" +
      "            </postMod>\r\n" +
      "            <head cat=\"VERB\">\r\n" +
      "              <base>be</base>\r\n" +
      "            </head>\r\n" +
      "          </vp>\r\n" +
      "        </child>\r\n" +
      "      </Document>\r\n" +
      "      <Realisation>There is an eccentric, tubular stenosis in the third obtuse marginal branch.There is an 80 % stenosis in the proximal right coronary artery.</Realisation>\r\n" +
      "    </Record>\r\n" +
      "  </Recording>\r\n" +
      "</NLGSpec>\r\n" +
      ""
  end

  test "realise appositive recording" do
    post :realise, xml: @appositive_payload
    assert_response :success
    assert_equal assigns[:realisation], "An angioplasty balloon catheter, the D701000000992, was deployed."
  end

  test "realise a problem recording" do
    post :realise, xml: @a_problem_payload
    assert_response :success
    assert_equal assigns[:realisation], "There is an eccentric, tubular stenosis in the third obtuse marginal branch.There is an 80 % stenosis in the proximal right coronary artery."
  end

end
