//
//  BabyProgress.swift
//  Ina
//
//  Created by Zachary Skemp on 6/6/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//


import UIKit

class BabyProgress: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var dday_bday_Label: UILabel!
    @IBOutlet weak var week_month_Label: UILabel!
    
    
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var babyImage: UIImageView!
    
    
    
    @IBOutlet weak var checklistControl: UISegmentedControl!
    @IBAction func checklistControl(_ sender: UISegmentedControl) {
        //Reload the data on change so the table can switch checklists based on this control
        self.tableView.reloadData()
    }
    @IBOutlet weak var tableView: UITableView!
    
    var arrayDaily = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Start UITableView
        tableView.delegate = self
        tableView.dataSource = self
        // Set up checkmarks
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.setEditing(true, animated: false)
        
        let preferences = UserDefaults.standard
        if (preferences.object(forKey: "DailyChecklist") == nil) {
            arrayDaily = [Bool](repeating: false, count: dailyChecklist.count)
        } else {
            arrayDaily = preferences.object(forKey: "DailyChecklist") as? [Bool] ?? [Bool]()
        }
        
        //Set up for Birthday Or Due Date
        let dueDateKey = "DueDate"
        let birthdayKey = "Birthday"
        
        // Checking if there is information stored for bday then due date key
        if preferences.object(forKey: birthdayKey) as! String? == "" {
            // LOGIC FOR DUE DATE
            if preferences.object(forKey: dueDateKey) as! String? != "" {
                let dateString = preferences.object(forKey: dueDateKey) as! String
                //Today's Date
                let date = Date()
                
                //Due Date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yy"
                let dueDate = dateFormatter.date(from: dateString)
                
                let calendar = Calendar.current
                let date1 = calendar.startOfDay(for: date)
                let date2 = calendar.startOfDay(for: dueDate!)
                
                let components = calendar.dateComponents([.day], from: date1, to: date2)
                let diffInDays = Float(components.day!)
                
                let weeksCompleted = 40 - (Int(diffInDays) / 7)
                let daysCompleted = (Int(diffInDays) % 7 + 1)
                let percentCompleted = 1.0 - (diffInDays / 280.0)
                
                dday_bday_Label.text = "Due Date: " + dateString
                week_month_Label.text = "Week " + String(weeksCompleted) + " Day " + String(daysCompleted)

                progressBar.setProgress(percentCompleted, animated: false)
                if (weeksCompleted > 39) {
                    informationTextView.text = weeklyInfo[39]
                    babyImage.image = fetalImageList[40]
                } else if (weeksCompleted < 0) {
                    informationTextView.text = weeklyInfo[0]
                    babyImage.image = fetalImageList[0]
                } else {
                    informationTextView.text = weeklyInfo[weeksCompleted-1]
                    babyImage.image = fetalImageList[weeksCompleted-1]
                }
            }
            //LOGIC FOR IF NEITHER DUE DATE OR BDAY
            else {
                
            }
        }
        // LOGIC FOR BIRTHDAY
        else {
            let dateString = preferences.object(forKey: birthdayKey)  as! String
            //Today's Date
            let date = Date()
            
            //Due Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            let dueDate = dateFormatter.date(from: dateString)
            
            let calendar = Calendar.current
            let date1 = calendar.startOfDay(for: date)
            let date2 = calendar.startOfDay(for: dueDate!)
            
            let components = calendar.dateComponents([.day], from: date2, to: date1)
            let diffInDays = Int(components.day!)
            
            let monthsCompleted = diffInDays / 30
            
            dday_bday_Label.text = "Baby's Birth Date: " + dateString
            week_month_Label.text = String(monthsCompleted) + " Months Old"
            
            babyImage.image = UIImage(named: "baby.jpg")!
            
            if (monthsCompleted > 35) {
                informationTextView.text = monthlyInfo[30]
            } else if (monthsCompleted > 23) {
                informationTextView.text = monthlyInfo[Int((monthsCompleted-23)/2)+23]
            } else if (monthsCompleted < 0) {
                informationTextView.text = monthlyInfo[0]
            } else {
                informationTextView.text = monthlyInfo[monthsCompleted-1]
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch checklistControl.selectedSegmentIndex {
        case 0:
            return dailyChecklist.count
        case 1:
            return trimester1Checklist.count
        case 2:
            return trimester2Checklist.count
        case 3:
            return trimester3Checklist.count
        default:
            return dailyChecklist.count
        }
        //return checklist.count// your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // your cell coding
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ChecklistTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChecklistTableViewCell
        
        // Fetches the appropriate term for the data source layout.
        var row = "Error"
        switch checklistControl.selectedSegmentIndex {
        case 0:
            row = dailyChecklist[indexPath.row]
        case 1:
            row = trimester1Checklist[indexPath.row]
        case 2:
            row = trimester2Checklist[indexPath.row]
        case 3:
            row = trimester3Checklist[indexPath.row]
        default:
            row = dailyChecklist[indexPath.row]
        }
        cell?.checkTextLabel.text = row
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selected code here
        arrayDaily[indexPath.row] = true
    }
    
    var weeklyInfo : [String] = ["If your egg is fertilized by a sperm, your baby begins as a single cell (known as a zygote).\r\n Your baby\'s weight is miniscule.\r\n Your baby (a zygote) begins to divide into multiple cells.", "Your baby’s cells will continue to divide as they travel down the fallopian tubes to your uterus.\r\n Your baby\'s weight is miniscule.\r\n Your baby’s cells begin to differentiate into 3 different types of tissue (the endoderm, the mesoderm, and the ectoderm). These three different types of tissue will eventually grow into different kinds of organs and organ systems as your baby matures. For example, the ectoderm will give rise to your baby’s skin and nervous system.", "Your baby is now a blastocyst, which is a microscopic ball of hundreds of rapidly dividing cells, and is nestled in the nutrient-rich lining of your uterus.\r\n Your baby\'s weight is miniscule.\r\n Your baby is starting to produce pregnancy hormone (hCG), which tells your ovaries to stop releasing eggs.","Your baby is the size of a poppy seed.\r\n Your baby\'s weight is less than 0.04 oz.\r\n Your baby is now officially an embryo! This is when you might be able to get a positive result on an at home pregnancy test.","Your baby is the size of a sesame seed.\r\n Your baby\'s weight is less than 0.04 oz.\r\n Your baby resembles a tadpole, and the circulatory system (including the heart and blood vessels) begins to form. Your baby’s tiny heart will begin to beat this week!","Your baby is the size of a pomegranate seed.\r\n Your baby\'s weight is less than 0.04 oz.\r\n Your baby\'s nose, mouth and ears are starting to take shape, and the intestines and brain are beginning to develop.","Your baby is the size of a blueberry.\r\n Your baby\'s weight is less than 0.04 oz.\r\n Your baby has doubled in size since last week, but still has a tail, which will soon disappear. Little hands and feet that look more like paddles are emerging from the developing arms and legs.","Your baby is the size of a kidney bean.\r\n Your baby\'s weight is less than 0.04 oz.\r\n Your baby has started moving around, though you won\'t feel movement yet. Nerve cells are branching out, forming primitive neural pathways. Your baby’s hands and feet now have webbed fingers and toes, which will soon give rise to individual fingers and toes. Breathing tubes now extend from your baby’s throat to developing lungs.","Your baby is the size of a cherry.\r\n Your baby\'s weight is around 0.07 oz.\r\n Your baby has graduated from an embryo to a fetus. Your baby\'s basic physiology is in place—the digestive tract and reproductive organs are formed, and your baby even has tiny earlobes!","Your baby is the size of a grape tomato or strawberry.\r\n Your baby\'s weight is around 0.14 oz.\r\n Your embryo has completed the most critical portion of development. Your baby’s skin is still translucent, but his tiny limbs can bend and fine details like nails and eyebrows are starting to form.","Your baby is the size of a Brussels sprout.\r\n Your baby\'s weight is around 0.25 oz.\r\n Your baby is almost fully formed. She\'s kicking, stretching, and even hiccupping as her diaphragm develops, although you can\'t feel any activity yet.","Your baby is the size of a plum or a lime.\r\n Your baby\'s weight is around 0.49 oz.\r\n Fingernails, toenails, and bones are forming, and a fine layer of hair covers most of her body. This week your baby\'s reflexes kick in. You baby will feel it if you gently poke your tummy – though you won\'t feel his or her movements yet.","Your baby is the size of a lemon.\r\n Your baby\'s weight is around 0.81 oz.\r\n Your baby\'s tiny fingers now have fingerprints, and veins and organs are clearly visible through your baby’s skin.","Your baby is the size of a nectarine.\r\n Your baby\'s weight is around 1.52 oz.\r\n Your baby\'s brain impulses have begun to fire and he\'s using his facial muscles. His kidneys are working now, too. ","Your baby is the size of an apple.\r\n Your baby\'s weight is around 2.47 oz.\r\n Your baby\'s eyelids are still fused shut, but she can sense light. His brain now controls all the muscles in her body; he is able to move. Yes, he\'ll even do somersaults! But if this is your first baby, you probably won\'t feel him moving for several more weeks.","Your baby is the size of an avocado.\r\n Your baby\'s weight is around 3.53 oz.\r\n The patterning on your baby\'s scalp has begun, though the hair isn\'t visible yet. Your baby’s legs are more developed and his or her head is more upright.","Your baby is the size of a turnip or an onion.\r\n Your baby\'s weight is around 4.94 oz.\r\n Your baby can move her joints, and her skeleton – formerly soft cartilage – is now hardening to bone. The umbilical cord is growing stronger and thicker.","Your baby is the size of a bell pepper or a sweet potato.\r\n Your baby\'s weight is around 6.70 oz.\r\n Your baby is now flexing his or her arms and legs. Internally, a protective coating of myelin is forming around his nerves.","Your baby is the size of a mango.\r\n Your baby\'s weight is around 8.47 oz.\r\n Your baby\'s senses – smell, vision, touch, taste and hearing – are developing and she may be able to hear your voice.","Your baby is the size of a banana or small artichoke.\r\n Your baby\'s weight is around 10.58 oz.\r\n Your baby can swallow now, and your baby’s digestive system is producing meconium, the dark, sticky goo that your baby will pass in his or her first poop.","Your baby will begin to jab or kick the wall of your womb.\r\n You may begin to notice patterns in your baby’s movements.\r\n Your baby\'s weight is around 0.75 pounds.\r\n Your baby is the size of a carrot.","Your baby now looks almost like a small newborn.\r\n Your baby has more developed lips and eyebrows, but does not have colored eyes yet.\r\n Your baby\'s weight is almost 1 pound.\r\n Your baby is roughly the size of a spaghetti squash.","Your baby’s ability to detect sounds is improving.\r\n Your baby\'s weight is just over 1 pound.\r\n Your baby is the size of a large mango.","Your baby is the size of an ear of corn.\r\n Your baby\'s weight is around 1.33 pounds.\r\n Your baby\'s skin is still translucent and thin.","Your baby is the size of a rutabaga.\r\n Your baby\'s skin is starting to become baby fat.\r\n Your baby\'s weight is around 1.5 pounds.\r\n Your baby’s hair is starting to grow, with its natural color and texture.","Your baby is the size of a bunch of scallions.\r\n Your baby\'s weight is around 1.67 pounds.\r\n Your baby is now inhaling and exhaling amniotic fluid.\r\n Through breathing the amniotic fluid in and out, your baby will start to develop lungs.","This is the last week of your second trimester.\r\n Your baby now has a regular sleep schedule and an active brain, but not yet fully formed lungs.n Your baby is the size of a head of cauliflower.\r\n Your baby\'s weight is almost 2 pounds.","Your baby is the size of a large eggplant.\r\n Your baby\'s weight is around 2.25 pounds.\r\n Your baby can blink and has grown eyelashes.\r\n Your baby is beginning to develop eyesight, and can sense light filtering in from outside the womb.","Your baby is the size of a butternut squash.\r\n Your baby\'s weight is around 2.5 pounds.\r\n Your baby is continuing to grow and develop its muscles and lungs, as well as its head for its brain!","Your baby is the size of a large cabbage.\r\n Your baby\'s weight is almost 3 pounds.\r\n Your baby is continuing to develop eyesight, but this likely won’t be fully developed until after birth.","Your baby is the size of a coconut.\r\n Your baby\'s weight is around 3.33 pounds.\r\n Your baby can turn its head from side to side. Your baby can also move around its limbs a lot more, so be prepared for more kicks!","Your baby is the size of a large jicama.\r\n Your baby\'s weight is around 3.75 pounds.\r\n Your baby now has fingernails, toenails, and real hair, and is still accumulating baby fat.","Your baby is the size of a pineapple.\r\n Your baby\'s weight is just over 4 pounds.\r\n Your baby\'s skeleton is firming up, but its head will still remain largely flexible until after birth.","Your baby is the size of a cantaloupe.\r\n Your baby\'s weight is around 4.75 pounds.\r\n Your baby\'s nervous system and lungs are maturing. Its skin is also very smoothed out now.","Your baby is the size of an honeydew melon.\r\n Your baby\'s weight is around 5.25 pounds.\r\n Your baby is getting pretty big for the womb, so it won’t be somersaulting much, but it’ll still be kicking! Also, its kidneys are fully developed by now, and its liver is almost ready.","Your baby is the size of a head of romaine lettuce.\r\n Your baby\'s weight is around 6 pounds.\r\n Your baby is shedding its vernix caseosa, which was the waxy substance covering the skin for the last nine months. This will be swallowed and incorporated into the meconium.","Your baby is the size of a bunch of Swiss chard.\r\n Your baby\'s weight is around 6.33 pounds.\r\n Your baby is continuing to fatten up before birth, and has grown out most of its hair, if any at all.","Your baby is the size of a leek.\r\n Your baby\'s weight is around 6.8 pounds.\r\n Your baby has matured its organs, and also now has a firm grasp to hold your hand with!","Your baby is the size of a mini-watermelon.\r\n Your baby\'s weight is just over 7 pounds.\r\n Your baby is now sloughing off old layers of skin for new, fresh ones.","Your baby is likely the size of a small pumpkin.\r\n Your baby\'s weight is around 7.5 pounds.\r\n Your baby’s skull is not yet fully fused, so that it can pass more easily through the birth canal."]
    
    var fetalImageList: [UIImage] = [
        UIImage(named: "week_1.jpg")!,
        UIImage(named: "week_2.jpg")!,
        UIImage(named: "week_3.jpg")!,
        UIImage(named: "week_4.jpg")!,
        UIImage(named: "week_5.jpg")!,
        UIImage(named: "week_6.jpg")!,
        UIImage(named: "week_7.jpg")!,
        UIImage(named: "week_8.jpg")!,
        UIImage(named: "week_9.jpg")!,
        UIImage(named: "week_10.jpg")!,
        UIImage(named: "week_11.jpg")!,
        UIImage(named: "week_12.jpg")!,
        UIImage(named: "week_13.jpg")!,
        UIImage(named: "week_14.jpg")!,
        UIImage(named: "week_15.jpg")!,
        UIImage(named: "week_16.jpg")!,
        UIImage(named: "week_17.jpg")!,
        UIImage(named: "week_18.jpg")!,
        UIImage(named: "week_19.jpg")!,
        UIImage(named: "week_20.jpg")!,
        UIImage(named: "week_21.jpg")!,
        UIImage(named: "week_22.jpg")!,
        UIImage(named: "week_23.jpg")!,
        UIImage(named: "week_24.jpg")!,
        UIImage(named: "week_25.jpg")!,
        UIImage(named: "week_26.jpg")!,
        UIImage(named: "week_27.jpg")!,
        UIImage(named: "week_28.jpg")!,
        UIImage(named: "week_29.jpg")!,
        UIImage(named: "week_30.jpg")!,
        UIImage(named: "week_31.jpg")!,
        UIImage(named: "week_32.jpg")!,
        UIImage(named: "week_33.jpg")!,
        UIImage(named: "week_34.jpg")!,
        UIImage(named: "week_35.jpg")!,
        UIImage(named: "week_36.jpg")!,
        UIImage(named: "week_37.jpg")!,
        UIImage(named: "week_38.jpg")!,
        UIImage(named: "week_39.jpg")!,
        UIImage(named: "week_40.jpg")!,
        UIImage(named: "week_41.jpg")!
    ]
    
    var monthlyInfo : [String] = ["Most babies will be able to suck well, focus on a face, and lift their heads briefly.\r\n It is normal for baby’s to sleep up to 18 hours out of 24 a day when they are younger than 3 months, but not more than 1 to 3 hours at a time.\r\n Play with your baby, keeping in mind that he/she can only see between 8-12 inches in front of his or her face. While you’re enjoying this one-on-one time, she’ll learn how to identify you by sight and sound at the same time you’re helping her to develop motor and cognitive skills.",
    "If your baby hasn\'t done so already, your baby is about to crack a spectacular toothless smile.\r\n She may also laugh, coo, and recognize your face and your voice about now.\r\n Start trying to recognize signs that your baby is tired (rubbing his eyes, flicking his ear with his hand, losing interest in people and toys), and put your baby down in his crib when you see them to help regulate his sleep.",
    "Your baby will have started or will start making their first sounds, especially different vowel noises.\r\n Your baby will continue to be more active.\r\n Be careful about baby safety — he\'s still pretty teeny and vulnerable to a host of serious injuries including shaken-baby syndrome. Hold off on the horseplay for now and focus on cuddles for a while longer.",
    "By this age, your baby can raise up on her arms when placed on her tummy (thanks to all the supervised tummy time you give her) and keep her head level when propped in a sitting position.\r\n He might even turn in the direction of your voice and complain if you take away his toy.\r\n You should still only be feeding your baby breast milk or formula at this age.",
    "Your baby has learned object permanence, so he’ll probably love playing peek-a-boo or finding “hidden” items.\r\n Your baby can start eating solids now.\r\n Eczema and food allergies often emerge around now, so be on the look out.\r\n For allergies, introduce new foods one at a time and wait two or three days before offering another new food. Keeping a food log can also help you pinpoint the cause if your baby has an adverse reaction.",
    "Your baby\'s probably able to bear weight on her legs when you hold her upright and may even be ready to hit the road, albeit at a crawl.\r\n If your baby is still not sleeping through the night, this may be a good time to consider some sleep strategies, like showing him the difference between night time and day time through different lights and sounds.",
    "Your baby can or will soon be able sit without support, and wave or play patty-cake.\r\n During this and the surrounding months, your child should eat a diet similar o around 1-3 teaspoons fruit in four feedings, 1-3 teaspoon vegetables in four feedings, and 3 to 9 tablespoons cereal in 2 or 3 feedings in addition to formula or breast milk.",
    "Gone are the days when your baby would stay where you plopped her. Most critters are ready to roll…and scoot, creep, crawl, or cruise.\r\n If baby’s show readiness for finger foods (like transferring items between hands and moving jaw in a chewing motion), you can start to feed her things like O-shaped cereal, small bits of scrambled eggs, well-cooked pieces of potato, or teething crackers.",
    "Listen up, Mom, and you\'ll start to hear emerging baby speech patterns. Also, your baby will probably be able to respond to simple commands (“Give mommy the cup”).\r\n Your easy-eater may become picky around now—you can mediate this by laying out a few nibbles for her to select from, and let her pick and choose.",
    "Your baby will be able to stand holding on, and may be able to stand alone (for a second) or even walk unassisted (the chase begins, Mom!).\r\n You (and/or your baby) may be ready to wean (or not) so make a plan (though be ready to revise your timetable, perhaps more than once).",
    "Your baby loves games — especially those that involve pointing — and his interest in books will grow exponentially as he begins to comprehend more and recognize familiar pictures.\r\n A few things not to be concerned about: bowed legs (almost always normal and temporary) and hitting milestones later than his peers.\r\nChildren learn best and build confidence when you let them learn at their own pace, but if you\'re truly concerned, check with your pediatrician.",
    "One-year-olds are pretty good at doing a few things for themselves, such as eating with their fingers, helping their parents dress them, and turning the pages of a storybook. Your baby should be starting to use a few everyday items correctly, including a spoon, telephone, and hairbrush.\r\n At this point, your baby can transition from human milk to cow milk (start with whole milk), and eat honey.",
    "Your baby will begin to stand on his or her own well.\r\n Your little one can still choke on chunks of food. Never offer peanuts, whole grapes, cherry tomatoes (unless they\'re cut in quarters), whole carrots, seeds (i.e., processed pumpkin or sunflower seeds), nor whole or large sections of hot dogs.",
    "Your baby will probably be able to walk well on his own.\r\n Don\'t restrict fats from your baby’s menu at this point. Babies and young toddlers should get about half of their calories from fat, which are very important for their growth and development at this age.",
    "About half of baby’s can walk backwards by 15 months.\r\n The generally agreeable nature of a 12-month-old can morph overnight into something more exhausting. Rigid, contrarian behavior shows that your child is beginning to understand a huge concept: She\'s a separate person from you.\r\n Baby’s need about 1,000 calories divided among three meals and two snacks per day for good nutrition. Don\'t count on your child always eating it that way though—the eating habits of toddlers are erratic and unpredictable from one day to the next!",
    "Your baby will be hard at work understanding rules (and also testing their limits).\r\n Bedtime will go more smoothly if you establish a routine your child can count on (like a bath, putting on pajamas, or reading a book).",
    "About half of babies at 17 months can walk up stairs with help.\r\n Lisping and mixing regular words with babbling phrases isn\'t unusual at 17 months. As your child\'s tongue and mouth muscles develop, enunciation should improve. Help him out by repeating what he says. ",
    "You baby should be able to speak at least 15 words by the end of 18 months.\r\n Don’t worry if your toddler suddenly decides to hate milk. Keep serving it, but don’t force her to drink it. Serve other diary products as well to make sure she is getting enough calcium.",
    "Your baby has a vocabulary of anywhere from 10 to 50 words.\r\n Your baby may also start testing backwards and sideways movements.\r\n Your baby needs between 11-14 hours of sleep a day.",
    "Your baby will start exploring its artistic skills, drawing simple lines and shapes.\r\n Your baby will start experimenting with fuller, simple sentences.\r\n Your baby needs between 11-14 hours of sleep a day.",
    "Your baby will begin to test its balance and climbing ability.\r\n Your baby can also now begin naming most body parts.\r\n Your baby needs between 11-14 hours of sleep a day.",
    "Your baby is beginning to explore its dexterity.\r\n Your baby can also start to ask simple questions.\r\n Your baby needs between 11-14 hours of sleep a day.",
    "Your toddler can likely follow simple two-step commands.\r\n Your toddler can also probably begin to undress itself.\r\n Your baby\'s weight is around 1.5 pounds.\r\n Your baby needs between 11-14 hours of sleep a day.",
    "Your toddler can regularly ask and answer questions.\r\n Your baby now should have a functional vocabulary of around 50 words.\r\n Your baby needs between 11-14 hours of sleep a day.",
    "Your toddler should start slimming down from its baby fat.\r\n Your toddler will have a lot more energy over the next year, and should get the chance to run around at least once a day.n Your child only needs between 9-13 hours of sleep at night for the next year.",
    "Your toddler can now easily handle small objects.\r\n This is the time when you will need to start setting rules for your toddler.\r\n Your child also now has a longer attention span, and might try to concentrate harder on simple tasks!",
    "Your child should be able to put on a few articles of clothing.\r\n Your toddler is going to expand its creativity through messiness, and may begin to remember friends by their names.\r\n This is around the time that you should begin potty-training your toddler!",
    "Your child now should have a basic understanding of adult behaviors and rules.\r\n Your toddler will now also begin to change its speech, depending on who it is speaking to.\r\n This is also around the time that your child will begin to tell fibs, because of its vivid imagination.",
    "Your child is beginning to develop its unique temperament - make sure to encourage your child to be its true self!\r\n This is also a critical time for ensuring that your child meets others and learns to share.\r\n Also, this is around the time that your toddler may begin to develop imaginary friends.",
    "Several of your child’s movements, like running and jumping, have become second nature.\r\n Your toddler likely only needs a short nap in the afternoon by this point - the days of long naps are behind you!\r\n This is also around the time that your child will be able to begin preparing its own food.",
    "Project Ina does not include information on children past the age of 3. Please see your local doctor for this information! :)"]

    var dailyChecklist : [String] = [
        "Drink water",
        "Eat healthy",
        "No smoking",
        "No drinking alcohol",
        "Not a lot of caffeine",
        "Avoid hazardous foods (could have bacteria, parasites, or toxins like raw fish)",
        "Stretch",
        "Sneak in a pregnancy power nap",
        "Try a relaxation technique",
        "Take a quick walk",
        "Eat a pregnancy superfood",
        "Write down your pregnancy memories",
        "Track your weight gain",
        "Do something nice for yourself",
        "Jot down your crazy pregnancy dreams",
        "Check in with a friend",
        "Know the signs of a pregnancy problem",
        "Take belly photos",
        "Have sex if you feel up to it",
        "Go to bed early",
        "Avoid unsafe activities"]
    var trimester1Checklist : [String] = [
        "Start taking a prenatal vitamin (make sure Folic Acid is included)",
        "Choose a healthcare provider",
        "Investigate what your health insurance will cover for prenatal costs and your new baby. Apply for Medicaid if you need to",
        "Make a prenatal appointment. Consult your provider about medications you’re taking",
        "Make sure your activities of daily life are pregnancy-safe",
        "Research prenatal exercises and talk to your doctor about which ones are safe",
        "Get relief from morning sickness",
        "Consider your options for prenatal testing",
        "Pick up pregnancy books",
        "Learn the signs of pregnancy problems",
        "Think about when and how you’ll announce your pregnancy",
        "Follow your baby’s development",
        "Start taking belly photos",
        "Stock your kitchen with healthy food",
        "Start a daily ritual to connect with your baby",
        "Buy some new bras and underwear",
        "Talk to your partner about parenting",
        "Start making a “Baby Budget”",
        "Research your birth plan",
        "If you are working, research your workplace’s maternity leave policies",
        "Learn about vaccines"]
    var trimester2Checklist : [String] = [
        "Learn about second-semester prenatal visits and tests",
        "Find a prenatal exercise class",
        "Start shopping for maternity clothes",
        "Decide whether to hire a professional labor coach (doula/midwife)",
        "Narrow your baby names list",
        "Plan some adult time",
        "Start moisturizing your belly",
        "Decide whether you want to find out the sex of your baby",
        "Look into childbirth classes",
        "Flesh out your “Baby Budget”",
        "Prepare your older children",
        "Prepare your pets",
        "Start your childcare search",
        "Get your teeth cleaned",
        "Celebrate your halfway point",
        "Start sleeping on your side",
        "Start doing Kegel exercises",
        "Talk to your employer about maternity leave",
        "Consider a “babymoon”",
        "Think about your baby shower. Create a baby registry",
        "Write a letter to your baby",
        "Tackle your home improvement projects",
        "Think about who will care for your baby (daycare, nanny, family member)",
        "Make dental appointment",
        "If you want to, find out the gender of your baby",
        "Research and order nursery furniture, strollers, car seats, and other baby supplies"]
    var trimester3Checklist : [String] = [
        "Finalize your birth plan",
        "Keep track of your baby’s movements",
        "Learn about third-trimester prenatal visits and tests",
        "Consider more classes",
        "Prepare for breastfeeding",
        "Choose a pediatrician",
        "Think about big decisions (like circumcision if your baby is a boy, religious ceremonies, etc.)",
        "Set up a safe place for your baby to sleep. Wash your baby’s clothing and bedding",
        "Learn about the stages of labor and coping with labor pain",
        "Start thinking about and contacting “helpers” (family, friends, daycare, etc)",
        "Finalize your “Baby Budget”. Consider the most financially stressful baby costs and how you can save",
        "Read up on baby care",
        "Pack your bag for the hospital or birth center",
        "Clean your house",
        "Stock up on household and personal supplies",
        "Make food for after your baby’s born",
        "Install your baby’s car seat",
        "Tour your hospital or birth center",
        "Make a plan for when labor starts",
        "Research and look out for late-pregnancy complications",
        "Think about baby names",
        "Cope with late pregnancy jitters",
        "Learn about how your body will look and feel after birth",
        "Stock up on light entertainment",
        "Research and look out for false labor signs",
        "Decide who will be in your delivery room",
        "Get tested for gestational diabetes",
        "Pre-register at your hospital"]

}
