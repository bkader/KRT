# KRT: Kader Raid Tools
AddOn Version: **0.5.4n**
Game Version: **3.3.5a**

Copyright (C) 2018 [Kader Bouyakoub](https://github.com/bkader)

![GUI Screenshot](screenshot.jpg "GUI Screenshot")

## What Features Does It Offer?

It was mainly made for raid leaders and it offers a lot of useful features to really make raid leading as easy as possible. To enumerate the features it offers, we go step by step:

### Grouping : LFM Spammer

If you ever got tired of spamming channels to gather the people you need! Even worst, as your group grows you will have to change the text you're sending all the time. Why bother? I have made the **LFM Spammer** for this purpose. Simply right click the minimap button the go for it. Or, you can use the command **/btm lfm** to toggle the main window.

The window explains itself in a very easy way. Just **name** the raid you are grouping for and enter the **composition** you need (Tanks, Healers, Melee and Ranged DPS). If you need to add extra info to your final **message** just add it to that section.

The classes boxes are used in case you need specific classes, so all you have to do is to type them there, comma-separated.

A good thing about the **Message** section is that it can detect **achievements IDs** if you type them between curly brackets. Example: **{1234}**.

**How am I supposed to know the ID?**

Don't worry, I knew you would ask! I provided the command **/btn ach xxxx** that you can use to find the ID. Example: **/btn ach fall of the lich king** ... It will then give you the ID that you can use it in your message.

After you have set everything up, all you need to add is the spam duration, select the channels you want to spam then hit **Start** ... Done!

**Notice**:
- The spammer stops if you edit any box to avoid having messed up message.
- To save what you have put into a text box you have two options: either you hit **Enter** or simply click elsewhere.
- The spammed message is stored across all your characters, so next time you login on another simply edit the its details.

## Raid Warnings (Pre-Saved)

A cool feature I have added to avoid writting during raids and having to type everthing over and over again, or worst, having to ALT+UP then edit. To access the raid warnings feature, right click the minimap button and hit **Raid Warnings**. Or faster, **/btn rw**.

Warnings are saved across your characters and you can have as many messages as you want, just make sure to give them proper names so that you remember them in the future.

Just start typing the **Name** (*optional*) and the **Message** (*required*) then hit **Save**. Done!

To announce a raid warning, simply select it (left-click) then hit **Announce**. Or faster, **Ctrl+Click** it. Or even faster (possibility to use macro), if you know its **ID**, do **/btn rw ID** and that's it.

You can delete a message by selecting it and hit **Delete** or edit it if you click the **Edit** button.

## Main Spec Changes (MS Changes)

This is one of the coolest features this addOn provides. Sometimes you get lost on who's wanted to roll for what, it's no longer the case. All you have to do now is to **Configure** MS Changes, enter the player's name and what he/she is rolling for.

You can either **Clear** everything and start over, you can as well **Ask For Changes** and finally **Spam Changes** to the raid so they know who's rolling as what.

**Tip**: If you want to spam a single player's MS Change, **Ctrl+Click**.

## Loot Bans (*in progress*)

Sometimes people just f\*\*\* up with tactics, and this is a cool feature I am currently working on that will allow you track who's banned from which boss' loot ... etc

## Loot Master

This feature is the first and most important feature I have created for this addOn. In fact, it was mainly created to be a master looting addOn but... Things change!

**What's different from other addOns?**

More friendly, easier to use and really made for laziest raid leaders ever.

You can either roll items on the boss kill or keep it for later (yes, this is one of different things it offers). The first thing you need to do is to go on the addOn's **Configuration** and set up what you need (self-explanatory), then you need to select:

- Loot **Holder**: which is the player who is going to keep the loot that's going to be rolled later (probably yourself).
- Loot **Banker**: in case you are reserving items (such us primordial saronites, bind on equipped ...etc) you may want to select this one. You can choose yourself but then you will have to deal with a messy inventory. You know what I mean!
- Loot **Disenchanter**: A loot of trash drop greens and blues that you need to disenchant! It is advised that the person assigned to this roll has Enchanting (it doesn't matter if they are BoEs).

### Window Buttons:

Going from top to bottom, here are the different buttons you will see on the main window:

- **Select Item** / **Remove Item**: Same button, different actions. If the item that appears is from a boss drop, clicking on this button with open a dropDown menu for you with all the boss loot so you can select which item you want to perform the next action on. But, in case the item was dropped on the addOn from inventory (case of later rolls), the button will simply removes it from the window.
- **Spam Loot** / **Ready Check**: for the same situations as the one above it, if it's from a boss you simply tell the raid what dropped, but if it's from your inventory, you tell people that you are going to roll and do a ready check before you start.
- **MS** / **OS** / **Free**: Simply announced the items you're rolling for main spec, off spec or if it's a free to roll item.
- **Countdown**: self-explanatory, you do a countdown before you change the roll or keep the item.
- **Award** / **Trade**: if the item comes from a boss and you click this button, it will assign it to him/her. Otherwise, if you hit trade, there are two scenarios: the player is far from you, so it will announce the winner and tell him/her to trade you, marking you as **Star** and the player as **Triangle**. The second scenario is the player is next to you, so when you hit the button it will automatically open the trade window and pick up the item from you to drop there, of course after announcing the winner's name.
- **Roll**: easy, if you want to roll, you can do the slash roll or hit this button.
- **Clear** / **Allow**: sometimes you want to clear the rolls and start over, this is the button for it. as for the second part, if you choose to ignore rolls after countdown, you won't see them there, so you simply hit the button and tell people to roll.
- **Hold** / **Bank** / **DE**: we talked earlier about loot people right? These are the buttons to assign the loot to them.

## Loot History (*Logger*)

More details about this one later.