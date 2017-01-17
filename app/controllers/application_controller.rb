class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    @words = []

  end

  def calculation
    #uploaded_file = params[:file]

    #file_content = uploaded_file.read
  file_content= "The Fight for Health Care has Begun
by David Leonhardt
NY Times

When House Republicans abandoned their plan to gut an independent ethics office last week, it showed the power of public opinion. It also offered a playbook for Democrats in 2017.

As soon as news of the original plan broke late last Monday afternoon, social media exploded with outrage. Phone calls poured in to Capitol Hill the next morning. At 10 a.m., Donald Trump distanced himself from the plan, and by midafternoon Republicans had folded.

We’ve seen this script before, but it has recently come from the political right more often than the left. The Tea Party and its allies managed to alter President Obama’s 2009 stimulus and 2010 health care law, as well as help block climate, preschool and infrastructure bills.

Remember, some of those victories came when Republicans didn’t control the White House or Congress. But they had other advantages: a focused message, a strong organization and a whole lot of passion. They influenced policy by striking political fear into members of Congress.

Now it’s the left’s turn to use public opinion, and the stakes in the next fight are bigger than the House ethics office.

Even before Trump becomes president, Congress is taking steps to deprive millions of people of health insurance. Democrats in Congress should do everything they can to thwart the effort. And if you’re one of those people who despaired after last year’s election — who wondered whether facts still mattered and whether there was anything you could do — you should get involved, too. How? I’ll get to that in a moment.

Republican leaders have muddied the Obamacare debate with bureaucratic jargon: deductibles, premiums, the individual mandate, repeal and delay. Don’t be fooled. The actual issues are straightforward.

Obamacare extended health insurance to more than 20 million people — middle-class, poor and sick people — and paid for it with taxes on the wealthy and corporations. It was the biggest attack on economic inequality since inequality began rising four decades ago.

Sam Jawitz is one of the beneficiaries. He was born almost two years ago in mid-coast Maine with a birth defect that left his throat unconnected to his stomach. His first month of care cost about $100,000.

His parents — small-business owners — would have spent their every dime, of course. But without Obamacare insurance, they would have gone deeply into debt, and Sam would have missed out on follow-up care and therapy. “We would have had to say, ‘Let’s only do some things,’” his mother, Alyce Ornella, said.

Today, Sam is an “outrageous” toddler, as his mom says, who will climb almost anything and likes to break into dance for no reason.

And Congress is on the verge of taking health insurance away from a lot of future Sams.

Republican leaders say they will repeal Obamacare with a delayed effective date and later make sure that people don’t lose insurance, but the leaders have no credible plan for doing so. They’re making an empty promise based on magical thinking. Two conservative experts published a devastating explanation in the journal Health Affairs last week.

Democrats have gotten off to a decent start in fighting back. A rigorous poll found that only 20 percent of Americans favor a repeal without an immediate replacement, and a handful of Senate Republicans have publicly expressed anxiety about repeal-and-delay.

But Senate Democrats still aren’t doing everything they can. Most important, they have not committed to dragging out the debate as long as possible later this week, by offering a blizzard of amendments. Once again, Democrats are at risk of bringing a knife to a gunfight.

Republicans plan to act quickly, without the months of hearings that Democrats held on Obamacare, for a reason: Transparency is the enemy of repeal. The more Americans who understand repeal, the more unpopular it will become.

What can you do? By all means, post messages on Facebook and Twitter if you want. But you can also do something more effective. You can call your senator.

Congressional staff members privately admit that they ignore many of the emails and letters they get. They also admit that phone calls are different. They have to answer them. Other people in the office hear the phone ringing and see their colleagues on the line. Phone calls are a tangible sign of public opinion, which is why they have been effective before.

If your senators are Republicans, tell them you’re part of the large majority of Americans who oppose repeal-and-delay. If they’re Democrats, tell them you want them to work harder — to stay on the Senate floor all night, if need be — fighting for people’s health care.

That’s what this is really about. It’s not about Obama or Trump or Congress. It’s about making sure that every citizen of the world’s most powerful country can receive modern medical care."

    sentences_num = sentences_count(file_content)
    words_num = word_count(file_content)
    syllables_num = syllabes_count

    @fi = 206.835 - 84.6 * (syllables_num/words_num) - 1.015 *(words_num/sentences_num)
    puts "NUMBER OF FI: " + @fi.to_s + " !!!!!!!!!!!!!"

  end

  private

  def sentences_count(text)
    sentences = text.split(/[.?!]/)
    print "NUMBER OF SENTENCES: " + sentences.count.to_s + " !!!!!!!!!!!!!"
    sentences.count
  end

  def word_count(text)
    @words = text.split(" ")
    print "NUMBER OF WORDS: " + @words.count.to_s + " !!!!!!!!!!!!!"
    @words.count
  end

  def syllabes_count
    #algorithm improved based on one part of this http://stackoverflow.com/a/5615724

    vowels = ["a", "e", "i", "o", "u"]
    syllables = 0

    @words.each do |word|
      vowel_in_latest = false
      word.split("").each do |char|
        vowel_found = false
        vowels.each do |vowel|
          if char == vowel
            syllables += 1 unless vowel_in_latest
            vowel_found = true
            vowel_in_latest = true
            break
          end
        end
        vowel_in_latest = false unless vowel_found
      end
      #remove 'es' ending
      syllables -= 1 if word.length > 2 && word[-2..-1] == 'es'
      #remove silent 'e'
      syllables -= 1 if word.length > 1 && word[-1..-1] == 'e'
    end
    print "NUMBER OF SYLLABLES: " + syllables.to_s + " !!!!!!!!!!!!!"
    syllables
  end
end
