//
//  Model.swift
//  Groupject
//
//  Created by Alexandra Daglio on 7/22/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import Foundation
import UIKit

class Model {
    //sort type
    enum SortByTypes {
        case filter
        case display
    }
    
    //category type
    enum categories {
        case annoucement
        case essentials
    }
    
    struct Announcement {
        var title: String?
        var description: String?
        var date: String?
        var location: String?
        var contactPerson: String?
        var announcer: String?
        var timeLimit: Double?
        var category: categories? //categories consist of Announcement or Essential
        var hours: String?
    }
    
    var arrayIndex: Int = 0
    var filterData = [Model.Announcement]()
    var isFilter: Bool?
    static let sharedInstance = Model() //obtain reference to the singleton
    private init () {
        //prevent unauthorized initialization & prevents overriding at init
    }
    
    
    
    //create the default announcements in the array:
    var announcementsArray: [Announcement]  = [
        Announcement(title: "12 Steps",
                      description: """
            1. We admitted we were powerless over our addictions and compulsive behaviors, that our lives had become unmanageable.
            I know that nothing good lives in me, that is, in my sinful nature. For I have the desire to do what is good, but I cannot carry it out. Romans 7:18 NIV
            
            2. We came to believe that a power greater than ourselves could restore us to sanity.
            For it is God who works in you to will and to act according to his good purpose. Philippians 2:13 NIV
            
            
            3. We made a decision to turn our lives and our wills over to the care of God.
            Therefore, I urge you, brothers, in view of God's mercy, to offer your bodies as living sacrifices, holy and pleasing to God - this is your  spiritual act of worship. Romans 12:1 NIV
            
            4. We made a searching and fearless moral inventory of ourselves.
            Let us examine our ways and test them, and let us return to the Lord. Lamentations 3:40 NIV
    
            5. We admitted to God, to ourselves, and to another human being the exact nature of our wrongs.
            Therefore confess your sins to each other and pray for each other so that you may be healed. James 5:16a NIV
    
            6. We were entirely ready to have God remove all these defects of character.
            Humble yourselves before the Lord, and he will lift you up. James 4:10 NIV
    
            7. We humbly asked Him to remove all our shortcomings.
            If we confess our sins, he is faithful and will forgive us our sins and purify us from all unrighteousness. 1 John 1:9 NIV
    
            8. We made a list of all persons we had harmed and became willing to make amends to them all.
            Do to others as you would have them do to you. Luke 6:31 NIV
    
            9. We made direct amends to such people whenever possible, except when to do so would injure them or others.
            Therefore, if you are offering your gift at the altar and there remember that your brother has something against you, leave your gift there in front of the altar. First go and be reconciled to your brother; then come and offer your gift. Matthew 5:23-24 NIV
    
            10. We continue to take personal inventory and when we were wrong, promptly admitted it.
            So, if you think you are standing firm, be careful that you don't fall! 1 Corinthians 10:12
            
            11. We sought through prayer and meditation to improve our conscious contact with God, praying only for knowledge of His will for us, and power to carry that out.
            Let the word of Christ dwell in you richly. Colossians 3:16a NIV
    
            12. Having had a spiritual experience as the result of these steps, we try to carry this message to others and practice these principles in all our affairs.
            Brothers, if someone is caught in a sin, you who are spiritual should restore them gently. But watch yourself, or you also may be tempted. Galatians 6:1 NIV
""",
                      date: nil,
                      location: nil,
                      contactPerson: nil,
                      announcer: "Roxy",
                      timeLimit: 5.00,
                      category: categories.essentials,
                      hours: "08AM - 06PM"),
         
         Announcement(title: "8 Principles",
            description: """
            1. Realize I’m not God; I admit that I am powerless to control my tendency to do the wrong thing and that my life is unmanageable. (Step 1)
            “Happy are those who know that they are spiritually poor.” Matthew 5:3a TEV

            2. Earnestly believe that God exists, that I matter to Him and that He has the power to help me recover. (Step 2)
            “Happy are those who mourn, for they shall be comforted.” Matthew 5:4 TEV, NIV

            3. Consciously choose to commit all my life and will to Christ’s care and control. (Step 3)
            “Happy are the meek.” Matthew 5:5a TEV

            4. Openly examine and confess my faults to myself, to God, and to someone I trust. (Steps 4 and 5)
            “Happy are the pure in heart.” Matthew 5:8a TEV

            5. Voluntarily submit to any and all changes God wants to make in my life and humbly ask Him to remove my character defects. (Steps 6 and 7)
            “Happy are those whose greatest desire is to do what God requires” Matthew 5:6a TEV

            6. Evaluate all my relationships. Offer forgiveness to those who have hurt me and make amends for harm I’ve done to others when possible, except when to do so would harm them or others. (Steps 8 and 9)
            “Happy are the merciful.” Matthew 5:7a TEV; “Happy are the peacemakers” Matthew 5:9 TEV

            7. Reserve a daily time with God for self-examination, Bible reading, and prayer in order to know God and His will for my life and to gain the power to follow His will. (Steps 10 and 11)

            8. Yield myself to God to be used to bring this Good News to others, both by my example and my words. (Step 12)
            “Happy are those who are persecuted because they do what God requires.” Matthew 5:10 TEV
            """,
            date: nil,
            location: nil,
            contactPerson: nil,
            announcer: "Mike",
            timeLimit: 5.00,
            category: categories.essentials,
            hours: "08AM - 06PM"),
         
         Announcement(title: "Serenity Prayer",
                      description: """
            God, grant me the serenity
            to accept the things I cannot change,
            the courage to change the things I can,
            and the wisdom to know the difference.
            Living one day at a time,
            enjoying one moment at a time;
            accepting hardship as a pathway to peace;
            taking, as Jesus did,
            this sinful world as it is,
            not as I would have it;
            trusting that You will make all things right
            if I surrender to Your will;
            so that I may be reasonably happy in this life
            and supremely happy with You forever in the next.

            Amen.
            """,
                      date: nil,
                      location: nil,
                      contactPerson: nil,
                      announcer: "Vanessa",
                      timeLimit: 5.00,
                      category: categories.essentials,
                      hours: "08AM - 06PM"),
         
         Announcement(title: "Small Group Guidelines",
                      description: """
            1. Keep your sharing focused on your own thoughts and feelings.
            Not your spouse’s, someone you’re dating, or your family members’ hurts and hang-ups, but your own. Focusing on yourself will benefit your recovery as well as the ones around you. Stick to “I” or “me” statements, not “you” or “we” statements.

            Limit your sharing to three to five minutes, so everyone has an opportunity to share — and to ensure that one person does not dominate the group sharing time.

            2. There is NO cross-talk. Cross-talk is when two people engage in conversation excluding all others. Each person is free to express his or her feelings without interruptions.
            Cross-talk is also making distracting comments or questions while someone is sharing. This includes speaking to another member of the group while someone is sharing, or responding to what someone has shared during his or her time of sharing.

            3. We are here to support one another, not “fix” one another. This keeps us focused on our own issues.
            We do not give advice or solve someone’s problem in our time of sharing or offer book referrals or counselor referrals!

            We are not licensed counselors, psychologists, or therapists, nor are the group members. Celebrate Recovery groups are not designed for this. It is up to the participants to include outside counseling to their program when they’re ready.

            4. Anonymity and confidentiality are basic requirements. What is shared in the group stays in the group. The only exception is when someone threatens to injure themselves or others.
            We are not to share information with our spouses/family/co-workers. This also means not discussing what is shared in the group among group members. This is called gossip.

            Please be advised, if anyone threatens to hurt themselves or others, the Small Group Leader has the responsibility to report it to the Celebrate Recovery Ministry Leader.

            5. Offensive language has no place in a Christ-centered recovery group.
            Therefore, we ask that you please watch your language. The main issue here is that the Lord’s name is not used inappropriately.

            We also avoid graphic descriptions. If anyone feels uncomfortable with how explicitly a speaker is sharing regarding his/her behaviors, then you may indicate so by simply raising your hand. The speaker will then respect your boundaries by being less specific in his/her descriptions. This will avoid potential triggers that could cause a person to act out.
            """,
                      date: nil,
                      location: nil,
                      contactPerson: nil,
                      announcer: "Phil",
                      timeLimit: 5.00,
                      category: categories.essentials,
                      hours: "08AM - 06PM"),
         
         Announcement(title: "12 Step Class Signups",
                      description: "Sign up for the 12 step classes. Starting February 4th, 2020. This is a great opportuinty to dig deeper into your recovery and find the root issues that are making life unmanagable for you. The classes follow 4 workbooks as a guide. You can purchase these workbooks as a set for $20, which you can write in and use over and over again, should you choose to retake the class in the future.",
                      date: "02-04-2020",
                      location: nil,
                      contactPerson: "Jackie",
                      announcer: "Jackie",
                      timeLimit: 5.00,
                      category: categories.annoucement,
                      hours: "08AM - 06PM"),
         
         Announcement(title: "CR Thanksgiving",
                      description: "Celebrate Recovery invites you and your immediate family to break bread with us and to celebrate the goodness of God at our annual Thanksgiving Fellowship Dinner. We'll provide the traditional turkey fixins' and fun. You provide the dessert, bottled water or canned sodas.",
                      date: "02-04-2020",
                      location: """
                        Miami Vineyard Community Church
                        12725 sw 122 ave
                        """,
                      contactPerson: "Jackie",
                      announcer: "Marie",
                      timeLimit: 5.00,
                      category: categories.annoucement,
                      hours: "08AM - 06PM"),
         
         Announcement(title: "Volunteers Needed",
                      description: "Volunteers needed to chaperone grade school-aged children to the Miami Seaquarium.",
                      date: "08-03-2020",
                      location: """
                        Hammocks Middle School
                        9889 Hammocks Blvd, Miami, Vineyard
                        """,
                      contactPerson: "Rosie",
                      announcer: "Rosie",
                      timeLimit: 5.00,
                      category: categories.annoucement,
                      hours: "08AM - 06PM")
    ] //end of array sample announcements
}

extension Model {
    //handle sort type
    func sortData(by: SortByTypes) {
        switch by {
        case .display:
            sortArray(data: announcementsArray)
        case .filter:
            sortArray(data: filterData)
        }
    }
    
    //generic function to sort
    func sortArray<T>(data: [T]) {
        //sort all the entries
        if !announcementsArray.isEmpty {
            announcementsArray.sort{
                $0.title ?? "" < $1.title ?? ""
            }
        }
    }
    
    //TODO not working
    //modified existing value
    //handle nil cases
    func overrideValue(
        description: String?,
        date: String?,
        hours: String?,
        location: String?,
        contactPerson: String?,
        timeLimit: Double?,
        index: Int?) {
        
        if let _index = index {
            //check if the value wasnt modifed
   
            if description == nil {
                
            }
            
            
            
            let value = announcementsArray[_index]
            announcementsArray[_index] = Announcement(title: value.title, description: description ?? "", date: date, location: location, contactPerson: contactPerson, announcer: value.announcer, timeLimit: timeLimit ?? 0, category: value.category, hours: hours ?? "")
        }
    }
    
    //TODO
    func addNew(data: Announcement) {
        //Dont add duplicate
    }
    
    //return data by categories
    func dataByCategories(category: categories) -> [Model.Announcement]? {
        switch category {
        case .annoucement:
           return Model.sharedInstance.announcementsArray.filter {
                $0.category == Model.categories.annoucement
            }
        case .essentials:
            return Model.sharedInstance.announcementsArray.filter {
                $0.category == Model.categories.essentials
            }
        }
    }
    
    //find item
    //remove at that index
    func delele(item: Announcement?) {
        guard let item = item else {
            return
        }
        if let index = announcementsArray.firstIndex(where: { $0.title == item.title}) {
            announcementsArray.remove(at: index)
        }
    }
}
