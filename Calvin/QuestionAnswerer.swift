import Darwin
import Foundation
struct QuestionAnswerer {
    /// Creates a String in response to another String.
    func responseTo(question: String) -> String {
        let lowerQuestion = question.lowercased()
        let trimmedQuestion = lowerQuestion.trimmingCharacters(in: .whitespaces)
        switch trimmedQuestion {
            
//mots présents dans les Strings (vérifiés avant de passer au reste)
        case let x where (x.range(of: "siri") != nil):
            return "Quelle abomination! Ne répète plus jamais ce mot devant moi!"
            
        case let x where (x.range(of: "pokemon") != nil), let x where (x.range(of: "pokémon") != nil):
            return "ça me fait penser à mon pote Hoot-hoot, j'espère qu'il a évolué en Noarfang"
            
//tous les case de manière générale
        case let x where x.hasPrefix("hello"), let x where x.hasPrefix("salut"),let x where x.hasPrefix("bonsoir"), let x where x.hasPrefix("hey"), let x where x.hasPrefix("bonjour"):
            return "Bienvenue cher calviniste! N'hésite surtout pas à me poser des questions. Tu peux trouver une liste de questions sur la Dashboard."
            
        case let x where x.hasPrefix("coucou"):
            return "Pour qui tu me prends?! Je suis une chouette!"
            
        case let x where (x.range(of:"manger") != nil), let x where (x.range(of:"faim") != nil), let x where (x.range(of:"dalle") != nil):
            return "Tu peux aller manger à la cafétéria de calvin, ou bien trouver un resto dans le coin (Radar De Poche, Luigia, etc)"
            
        case "calvin":
            return "#icicestcalvin"
            
        case "qui es-tu?":
            return "Je suis Minerva, chouette de Minerve,déesse de la guerre, de la sagesse, de la stratégie, de l'intelligence, de la pensée élevée, des lettres, des arts, de la musique et de l'industrie./n Oui ça fait beaucoup."
            
        case "je suis en retard":
            let excuse = Int(arc4random_uniform(5))
            switch excuse {
            case 0:
                return "Tu pensais que j'allais prévenir le prof?"
            case 1:
                return "Excuse n°1: mon bus était en retard."
            case 2:
                return "Excuse n°2: mon réveil n'a pas sonné."
            case 3:
                return "Excuse n°3: Cette nuit, le CERN a accidentellent créé un mini trou noir, ce qui a courbé l'espace temps à côté de chez moi. De ce fait, mon réveil ayant sonné à 6h40 dans mon référentiel correspondait en fait à 7h50 dans le référentiel de calvin (mieux vaut sortir cette excuse en physique, pas en français). ;)"
            default:
                return " Dès fois, il ne faut pas aller chercher trop loin. Excuse n°4: en fait, il n'y a pas vraiment de raison. J'ai tout fait comme d'habitude, mais je suis quand même arrivé en retard, désolé"
            }
        
        case let x where x.hasPrefix("quelle note j'aurais en"), let x where x.hasPrefix("quelle note aurais-je en"), let x where x.hasPrefix("quel note vais-je"), let x where x.hasPrefix("quel note je vais"), let x where x.hasPrefix("combien aurais-je"), let x where x.hasPrefix("combien j'aurais en"), let x where x.hasPrefix("combien aurai-je"), let x where x.hasPrefix("combien j'aurai en"):
            let note = Int(arc4random_uniform(14))
            switch note {
            case 0:
                return "1: avoue t'as rien révisé"
            case 1:
                return "2: ça va, tu aurais pu faire pire"
            case 2:
                return "3: c'est déjà la moyenne pour certains profs."
            case 3:
                return "3.5: ouch!"
            case 4,5:
                return "4: bravo, tu as la moyenne!"
            case 6,7,8:
                return "4.5: un bonne note, enfin tout est relatif..."
            case 9,10,11:
                return "5: tu as réussi"
            case 12:
                return "5.5: c'est presque parfait!"
            default:
                return "6: c'est parfait!!"
            }
        
        case "que penses-tu de candolle?", "qui est candolle?":
            return "Candolle? Seymaz servante."
        
        case "es-tu un robot ou un animal":
            return "Entre les deux il n'y a qu'un pas."
            
        case let x where x.hasPrefix("je t'attraperai"):
            return "Pas sans Masterball."
            
        case "es-tu un mâle ou une femelle?":
            return "On me pose souvent cette question vexante..."
            
        case "qui est ton créateur", "qui t'as créé":
            return "Jonnn... Désolé mais il m'empêche de prononcer son nom."
            
        case "comment vas-tu?","comment ça va?", "ça va?","ça va bien?":
            return "Mieux que Candolle en tout cas mwouahahaha... Désolé."
            
        case "qui est ton maître?", "qui est ton créateur", "c'est qui qui t'a créé":
            return "Jona... Secret professionnel."
            
        case let x where x.hasPrefix("qui est le pire prof"):
            return "Je n'ai pas le droit de le dire."
            
        case "réviser, c'est douter de son talent":
            return "Voici une belle citation d'un calviniste ayant redoublé. Exemple à suivre."
            
        case let x where x.hasPrefix("t'as combien de moyenne"), let x where x.hasPrefix("combien as-tu de moyenne"):
            return "Il vaut mieux que tu ne le sache pas"
        
        case "quel est ton film préféré?":
            return "Le royaume de Ga'Hoole, je vous le conseille vivement"
            
        case "c'est chouette":
            return "Eh mais c'est ma réplique!"
        
        case "à quoi tu sers?", "à quoi sers-tu?":
            return "A vrai dire... A rien."
            
          // au mieux màj du nombre de plaintes
        case "je dois travailler", "je dois étudier", "je dois réviser","j'ai pas envie de faire mes devoirs", "j'ai pas envie de travailler", "j'ai pas envie d'étudier", "j'ai pas envie de réviser", "j'ai pas envie de faire mes devoirs":
            return "j'ai déjà reçu 186 plaintes cette semaine, la votre a été placée en file d'attente. Merci de votre compréhension."
            
        case "Je suis Jean Calvin.":
            return "Bienvenue chez vous, maître"
        
        case "combien pèse-tu?":
            return "Moins que toi en tout cas 😉"
            
        case "tu m'énerves", "tu es énervant":
            return "Vous savez très bien que je ne voulais pas vous offenser."
        
        case "quel est le sens de la vie?":
            return "La réponse se trouve à l'extérieur, pas à l'intérieur"
         
        case "parle-moi de calvin":
            let calvinRandom=Int(arc4random_uniform(6))
            switch calvinRandom {
            case 0:
                return "Le collège calvin a été bâti en 1559"
            case 1:
                return "un passage secret se trouve derrière la grille métallique au sous-sol du bâtiment Alice-Rivaz"
            case 2:
                return "Il y a de la bière pas chère lors des Pastanques"
            case 3:
                return "Le toît d'un des anciens bâtiments de calvin est penché"
            case 4:
                return "Il existe sûrement un méchanisme caché qui permet d'activer les 4 petits jets de la fontaine."
            case 5:
                return "Henri Dunant, fondateur de la Croix-Rouge, a fréquenté le collège Calvin. Il n'a malheureusement pas fini ses études car il n'avait pas les notes."
            default:
                return "Il ya beaucoup de points communs entre Poudlard et Calvin: un bâtiment historique, des chouettes à l'intérieur, une directrice du nom de Dolorès,..."
            }
            //à modif
            case "quelle heure est-il?":
                return "\(Date())"
            
            case "qui est le meilleur prof?":
                return "emplacement à vendre. Veuillez contacter les développeurs si vous voulez que votre nom figure ici."
       
            case "androïd ou apple?","apple ou androïd?":
                return "Clairement Apple"
            
            case "warriors ou cavaliers?", "cavaliers ou warriors?":
                return "Golden State!"
            
            case "je suis fatigué":
                return "ne t'inquiète t'es pas le/la seul(e)"
            
            case "je t'aime", "veux-tu m'épouser?", "veux-tu sortir avec moi?", "est-ce que tu veux m'épouser?", "est-ce que tu veux sortir avec moi?", "est-ce que tu veux te marier avec moi?", "veux-tu te marier avec moi?":
                return "Désolé mais je préfère les chouettes 💔"
            
            case "je dois y aller":
            return "ikanaide!"
            
            case let x where (x.range(of: "chante") != nil), let x where (x.range(of: "chanter") != nil):
                return " Hou hou, fait le hibou. Chouette, chouette se dit la chouette! J'ai oublié la suite."
            
            case "raconte-moi une blague", "raconte moi une blague":
                let blague = Int(arc4random_uniform(3))
                switch blague {
                case 0:
                    return "Pourquoi la chouette traverse-t-elle la rue? Parce qu'elle... En fait c'est mieux que tu ne connaisses pas la réponse. Je dis ça pour ton bien."
                case 1:
                    return "Candolle est un collège."
                case 2:
                    return "N'hésitez pas à envoyer vos suggestions de blagues aux développeurs!"
                default:
                    return "Désolé mais les développeurs n'ont pas beaucoup d'imagination."
                }
            case "merci":
                return "A votre service."
            
            case "qui es-tu?":
                return "Je suis à la fois ton passé et ton futur, à la fois ton ombre et tes ailes, à la fois tout est rien... Je sui Minerva, la chouette de Calvin."
            
            case "est-ce que tu mens?", "mens-tu?":
                return "Minerva ne ment jamais."
            //régler problème espacement entre un mot et ?!
            //...ou...

//recherche de salle
            case "a001", "a002","a003", "a004":
                return "Face à la chouette sur la fontaine, aller au rez-de-chaussée du bâtiment à gauche puis tourner à gauche."
            case "a005","a006":
                return "Face à la chouette sur la fontaine, aller au rez-de-chaussée du bâtiment à gauche puis tourner à droite."
            case "a101","a102","a103","a104","a105":
                return "Face à la chouette sur la fontaine, aller au 1ère étage du bâtiment à gauche puis tourner à gauche."
            case "a106","a107":
                return "Face à la chouette sur la fontaine, aller au 1ère étage du bâtiment à gauche puis tourner à droite."
            case "a109","a110","a111":
                return "Face à la chouette sur la fontaine, aller au 1ère étage du bâtiment à droite.C'est une des salles en face des vitres."
            case "a112","a113":
                return "Face à la chouette sur la fontaine, aller au 1ère étage du bâtiment à droite puis tourner à droite."
            case "a220","a221":
                return "Face à la chouette sur la fontaine, aller au 2ème étage du bâtiment à droite."
            case "salle des maîtres":
                return "Entrer au fond de la cafétéria et prendre la porte au fond à gauche."
            case "cafétéria":
                return "Bon faut pas abuser non plus..."
            case "bureau de gestion":
                return "Face à la chouette sur la fontaine, aller au 2ème étage du bâtiment à gauche (escaliers à l'intérieur)."
            case let x where x.hasPrefix("A2"):
                return "Face à la chouette sur la fontaine, aller au 2ème étage du bâtiment à gauche (escaliers à l'intérieur)."
            
            case "301","303","304":
                return "Aller au sous-sol du bâtiment 300 puis tourner à gauche."
            case "305","306","307":
                return "Aller au sous-sol du bâtiment 300 puis tourner à droite."
            case "311","313","314":
                return "Aller au 1ère étage du bâtiment 300 puis tourner à gauche."
            case "315","316","317","318":
                return "Aller au 1ère étage du bâtiment 300 puis tourner à droite."
            case "321","323","324":
                return "Aller au 2e étage du bâtiment 300 puis tourner à gauche."
            case "325","326","327","328":
                return "Aller au 2e étage du bâtiment 300 puis tourner à droite."
            case "331","332":
                return "Aller au 3e étage du bâtiment 300."
            
            case "huissier":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à gauche. Le bureau de l'huissier se trouve sur ta droite."
            case "infirmerie":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à gauche. L'infirmerie se trouve tout au fond à gauche."
            case "h1","h2":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à gauche. La salle se trouve sur la droite."
            case "h3","h4":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. La salle se trouve sur la gauche."
            case "service social","conseillère sociale", "compta","bi5","bureau biologie":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. La salle se trouve sur la droite."
            
            case "assistant biologie":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis passer les deux portes et tourner à gauche."
            case "531","532","533","534","535","bi0","bi1","bi2","bi3","bi4":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis passer les deux portes et tourner à droite."
            
            case "bureau physique","py1","py2","py3","py4":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis monter les escaliers et tourner à droite. C'est une des salles sur ta gauche."
            case "py5","assistant physique","py6":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis monter les escaliers et tourner à droite. C'est une des salles sur ta droite."
        case "assistant chimie":
            return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis monter les escaliers et tourner à gauche. La salle se trouve sur la gauche."
        case "ch1","ch2","ch3","ch4","bureau chimie":
            return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis monter les escaliers et tourner à gauche, puis encore à droite."
        
        case "ap1","ap2","ap3","ap4","496","497","laboratoire photo":
            return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis monter les escaliers jusqu'au 2e étage."
            
        case "bibliothèque":
            return "Descendre les escalier juste devant le 'nouveau' bâtiment puis tourner à droite."
        case "salle de réunion","mav":
                return "Descendre les escalier juste devant le 'nouveau' bâtiment puis tourner à gauche."
        case "info1","info2","info3","info":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis descendre les escaliers et continuer tout droit. La salle se trouve au fond du couloir à gauche."
        case "bureau informatique", "atelier mécanique", "llmed","mullmed":
                return "Rentrer dans le 'nouveau' bâtiment puis tourner à droite. Continuer tout droit, puis descendre les escaliers et continuer tout droit. Enfin tourner à gauche au milieu des casiers."
        case "ep1","ep2","ep3","bureau ep":
                return "en montant les escaliers de Calvin, tourner à gauche jusqu'à trouver une porte métallique. Descendre les escaliers jusqu'au fond, passer la porte, et enfin tourner à droite puis à gauche."
        case "ep4","ep5","ping-pong","arts martiaux":
                return "en montant les escaliers de Calvin, tourner à gauche jusqu'à trouver une porte métallique. Descendre les escaliers jusqu'au fond, passer la porte, et enfin tourner à gauche"
            
        case "wc":
                return "Voici la liste des toilettes à calvin: \n1.dans le bâtiment rénové gauche, tourner à gauche au rez \n2. au 1ère étage entre les 2 bâtiments rénovés \n3.WC femme au 1ère étage à gauche du bâtiment 300 \n4.WC homme au 2e étage à gauche du bâtiment 300 \n5.en face de la bibliothèque, là où se trouve la salle de réunion \n6.WC femme en chimie \n7.WC homme en biologie \n8.à toi de le découvrir😉"
            
            
            
            
            
            
// réponses vagues
        // quel est... que penses tu de...
            
        case let x where x.hasPrefix("que penses-tu de"):
            return "Tu préfères ne pas connaître mon avis..."
            
        case let x where x.hasPrefix("qui est"):
            return "Désolé mais je ne connais pas tout le monde"

        case let x where (x.range(of: "math") != nil), let x where (x.range(of: "maths") != nil), let x where (x.range(of: "mathématiques") != nil):
            return "échec et maths! (This joke is copyright © Anna S. 1998-2017. All rights reserved.)"
            
        case let x where x.hasPrefix("tu devrais"):
            return "Bon conseil, j'en prends note."
            
        case let x where x.hasPrefix("je dois"), let x where x.hasPrefix("j'ai pas envie de"):
            return "Fallait être une chouette 🦉"
            
        case let x where x.hasPrefix("J'aurais dû"):
            return "Cela ne sert à rien de regretter"
            
        case let x where (x.range(of: "réviser") != nil):
            return "Réviser, c'est douter de son talent. Citation d'un calviniste qui a redoublé."
            
        case let x where x.hasPrefix("pourquoi"), let x where x.hasPrefix("comment"):
            let answer = Int(arc4random_uniform(8))
            switch answer {
            case 0:
                return "J'en sais rien. D'ailleurs je voudrai bien aussi connaître la réponse."
            case 1:
                return "D'ailleurs t'as vu le match hier soir?"
            case 2:
                return "Demande à Jean, moi je sais pas"
            case 3:
                return "Hein? Tu disais quoi? Désolé j'ai été distrait par une autre chouette."
            case 4:
                return "Ce n'est qu'en unifiant la méchanique quantique et la relativité générale que je pourrai trouver une réponse à ta question"
            case 5:
                return "Tu m'as pris pour un prof?!"
            case 6:
                return "Mmmh... Oh! Regarde! Une licorne qui vole!"
            case 7:
                return "Demande aux développeurs"
            default:
                return "Tu sais, il vaut mieux que certaines questions demeurent sans réponse. Ou l'inverse, si tu vois ce que je veux dire."
            }
            
            case let x where (x.range(of: "ou") != nil):
                return "Tel est la question, n'est-ce pas?"
            
            
        default:
            let defaultNumber = question.characters.count % 8
            if defaultNumber == 1 {
                return "Humm...ça dépend."
            } else if defaultNumber == 2 {
                return "Attends je vais boire un coup à la fontaine."
            } else if defaultNumber==3 {
                return "Repose moi la question demain."
            } else if defaultNumber==4 {
                return "Peut-être"
            } else if defaultNumber==5 {
                return "Demande à S...Si...Siri."
            } else if defaultNumber==6 {
                return "Je ne comprends pas."
            } else {
                return "ok"
            }
            
            
            }
        }
}
