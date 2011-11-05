module NumberWords

  DIGITS = {  1=>"one",
              2=>"two",
              3=>"three",
              4=>"four",
              5=>"five",
              6=>"six",
              7=>"seven",
              8=>"eight",
              9=>"nine",
              0=>"zero" }
              
  TENS = {  0=>"zero",
            10=>"ten",
            20=>"twenty",
            30=>"thirty",
            40=>"forty",
            50=>"fifty",
            60=>"sixty",
            70=>"seventy",
            80=>"eighty",
            90=>"ninety" }
            
  TEENS = {  11=>"eleven",
                12=>"twelve",
                13=>"thirteen",
                14=>"fourteen",
                15=>"fifteen",
                16=>"sixteen",
                17=>"seventeen",
                18=>"eighteen",
                19=>"nineteen" }
                
  KEYWORDS = {  "zero"=>0,
                "one"=>1,
                "two"=>2,
                "three"=>3,
                "four"=>4,
                "five"=>5,
                "six"=>6,
                "seven"=>7,
                "eight"=>8,
                "nine"=>9,
                "ten"=>10,
                "eleven"=>11,
                "twelve"=>12,
                "thirteen"=>13,
                "fourteen"=>14,
                "fifteen"=>15,
                "sixteen"=>16,
                "seventeen"=>17,
                "eighteen"=>18,
                "nineteen"=>19,
                "twenty"=>20,
                "thirty"=>30,
                "forty"=>40,
                "fifty"=>50,
                "sixty"=>60,
                "seventy"=>70,
                "eighty"=>80,
                "ninety"=>90 }

  ###############################################
  #  Convert space delimited word form to number
  # 
  def self.getNumber( wordForm )
    
    words = wordForm.split
    
    words.inject(0) { |number, word| number += KEYWORDS[word]  }
    
  end


  ###############################################
  #  Convert number to space delimited word form
  # 
  def self.validate( number )
    
    if number.is_a?(Fixnum) # Check valid type  
      if number >= 0 and number < 100 # Check valid range
        return true
      end
    end
    raise "This number cannot be converted in this version of NumberWords"
  end
  
  
  
  def self.getString( number )
    self.validate( number )
    
    if number < 10
      DIGITS[number]
    elsif number < 20 and number != 10
      TEENS[number]
    elsif number % 10 != 0 # Not a multiple of 10
      TENS[(number/10)*10] + " " + DIGITS[number%10]
    else # is a multiple of ten
      TENS[number]
    end
  end
  
end


require "test/unit"

class TestNumberWords < Test::Unit::TestCase
  
  def test_true
    assert true
  end
  
  # TODO -- Test string conversion more
  def test_strings
    assert_equal(1, NumberWords.getNumber("one"))
    assert_equal(22, NumberWords.getNumber("twenty two"))
    assert_equal(20, NumberWords.getNumber("twenty"))
  end
  
  def test_one
    assert_equal(NumberWords.getString(1), "one")
  end
  
  def test_all_digits
    assert_equal(NumberWords.getString(1), "one")
    assert_equal(NumberWords.getString(2), "two")
    assert_equal(NumberWords.getString(3), "three")
    assert_equal(NumberWords.getString(4), "four")
    assert_equal(NumberWords.getString(5), "five")
    assert_equal(NumberWords.getString(6), "six")
    assert_equal(NumberWords.getString(7), "seven")
    assert_equal(NumberWords.getString(8), "eight")
    assert_equal(NumberWords.getString(9), "nine")
    assert_equal(NumberWords.getString(0), "zero")
  end
  
  def test_multiples_of_ten
    assert_equal(NumberWords.getString(10), "ten")
    assert_equal(NumberWords.getString(20), "twenty")
    assert_equal(NumberWords.getString(30), "thirty")
    assert_equal(NumberWords.getString(40), "forty")
    assert_equal(NumberWords.getString(50), "fifty")
    assert_equal(NumberWords.getString(60), "sixty")
    assert_equal(NumberWords.getString(70), "seventy")
    assert_equal(NumberWords.getString(80), "eighty")
    assert_equal(NumberWords.getString(90), "ninety")
  end
  
  def test_teens
    assert_equal(NumberWords.getString(11), "eleven")
    assert_equal(NumberWords.getString(12), "twelve")
    assert_equal(NumberWords.getString(13), "thirteen")
    assert_equal(NumberWords.getString(14), "fourteen")
    assert_equal(NumberWords.getString(15), "fifteen")
    assert_equal(NumberWords.getString(16), "sixteen")
    assert_equal(NumberWords.getString(17), "seventeen")
    assert_equal(NumberWords.getString(18), "eighteen")
    assert_equal(NumberWords.getString(19), "nineteen")
  end
  
  def test_twenties
    assert_equal(NumberWords.getString(21), "twenty one")
    assert_equal(NumberWords.getString(22), "twenty two")
    assert_equal(NumberWords.getString(23), "twenty three")
    assert_equal(NumberWords.getString(24), "twenty four")
    assert_equal(NumberWords.getString(25), "twenty five")
    assert_equal(NumberWords.getString(26), "twenty six")
    assert_equal(NumberWords.getString(27), "twenty seven")
    assert_equal(NumberWords.getString(28), "twenty eight")
    assert_equal(NumberWords.getString(29), "twenty nine")
  end
  
  def test_randoms
    assert_equal(NumberWords.getString(99), "ninety nine")
    assert_equal(NumberWords.getString(72), "seventy two")
  end
  
  def test_invalid_input
    exceptions = []
    exceptions << assert_raise(RuntimeError){NumberWords.getString(1.1)}
    exceptions << assert_raise(RuntimeError){NumberWords.getString(-1)}
    exceptions << assert_raise(RuntimeError){NumberWords.getString(100)}

    exceptions.each do |e|
      assert_equal("This number cannot be converted in this version of NumberWords", e.message)
    end
  end
  
end