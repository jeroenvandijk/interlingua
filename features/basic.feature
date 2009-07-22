Feature: dynamically add steps
  In order to become more productive
  As a developer
  I want to have standard steps in several languages
  
  Scenario: available steps
  Given I have a file "features/dutch.feature" with:
    """
    Functionaliteit: voorbeeld feature
      Om productiever te worden
      Als ontwikkelaar
      Wil ik dat de volgende stappen via een API herkend worden aangeroepen

      Scenario: voorbeeld
        Gegeven dat ik op x ben
        En ik op x ben
        Gegeven dat de volgende komkommers bestaan
          | naam | kleur  |
          | cuke  |  rood |
        En de volgende komkommers bestaan
          | naam | kleur  |
          | cuke  |  rood |
        Gegeven dat het volgende object bestaat
          | naam | kleur  |
          | cuke  |  rood |
        En het volgende object bestaat
          | naam | kleur  |
          | cuke  |  rood |
        Als ik naar de x ga
        Dan zou ik "komkommer 1" moeten zien
        En ik zou "komkommer 1" moeten zien
        Dan zou ik niet "komkommer 2" moeten zien
        En ik zou niet "komkommer 2" moeten zien
    """
  And I have a file "features/support/env.rb" with:
    """
    require File.join(File.dirname(__FILE__), "/../../../lib/cucumber_support/cucumber")
    
    module SimpleWorld
      def method_missing(*args)
        method, *arguments = *args
        puts "#{method}(#{arguments.inspect})"
      end
    
    end
    
    World(SimpleWorld)
    """
  
  When I run "cucumber features/dutch.feature --language nl"
  Then I should see
    """
    Functionaliteit: voorbeeld feature
      Om productiever te worden
      Als ontwikkelaar
      Wil ik dat de volgende stappen via een API herkend worden aangeroepen

      Scenario: voorbeeld                          # features/dutch.feature:6
        Gegeven dat ik op x ben                    # (eval):1
        En ik op x ben                             # features/dutch.feature:8
        Gegeven dat de volgende komkommers bestaan # (eval):1
          | naam | kleur |
          | cuke | rood  |
        En de volgende komkommers bestaan          # features/dutch.feature:12
          | naam | kleur |
          | cuke | rood  |
        Gegeven dat het volgende object bestaat    # (eval):1
          | naam | kleur |
          | cuke | rood  |
        En het volgende object bestaat             # features/dutch.feature:18
          | naam | kleur |
          | cuke | rood  |
        Als ik naar de x ga                        # (eval):1
        Dan zou ik "komkommer 1" moeten zien       # features/dutch.feature:22
        En ik zou "komkommer 1" moeten zien        # features/dutch.feature:23
        Dan zou ik niet "komkommer 2" moeten zien  # features/dutch.feature:24
        En ik zou niet "komkommer 2" moeten zien   # features/dutch.feature:25
    
    
    1 scenario (1 undefined)
    11 steps (3 skipped, 7 undefined, 1 passed)
    
    """
