# Core
This for fivem custom framework.
This is has basic function and some infinity code. (np-infinity and other one)

Fivem için özel bir framework.
İçinde kolaylık sunan ve gereksiz script olarak kullanılan kodlar bulunmaktadır (parmakla gösterme , taşıma, crosshair silme vb.). Infinity'e yardımcı kodlar bulunmaktadır.


# Örnek Export Kullanımı / Example Export Using

Client side:

```lua
exports['rwr-core']:ShowNotify(text, box color, text color, duration(in seconds))
```

Server side:

```lua
TriggerClientEvent('RWR:ShowNotification', source, text, box color, text color, duration)
```

## Using Font Awesome icons

You can simply add icons to your notifications, when you add them to text.

## Examples

Client side:

```lua
exports['rwr-core']:ShowNotify('Hello world!', '#35889e', '#ffff', 1)
```

Server side:

```lua
TriggerClientEvent('RWR:ShowNotification', source, 'Hello world!', '#35889e', '#ffff', 1)
```

With icons:

```lua
exports['rwr-core']:ShowNotify('<i class="fas fa-info-circle">Hello world!</i>', '#35889e', '#ffff', 1)
```

```lua
TriggerClientEvent('RWR:ShowNotification', source, '<i class="fas fa-info-circle">Hello world!</i>', '#35889e', '#ffff', 1)
```
## InteractionMenu
Show:

```lua
exports['rwr-core']:ShowInteraction(text, stripe color, text color)
```

Hide:

```lua
exports['rwr-core']:HideInteraction()
```

## Using Font Awesome icons

You can simply add icons to your notifications, when you add them to text.

## Examples

```lua
exports['rwr-core']:ShowInteraction('[E] Open menu', '#9f2fb2', '#ffff')
Citizen.Wait(1000)
exports['rwr-core']:HideInteraction()
```

With icons:

```lua
exports['rwr-core']:ShowInteraction('<i class="fas fa-info-circle">[E] Open menu</i>', '#9f2fb2', '#ffff')
Citizen.Wait(1000)
exports['rwr-core']:HideInteraction()
```

## Credit

https://github.com/freddycz/fs_notify
https://github.com/freddycz/fs_interactionmenu

# Preview
https://prnt.sc/1qhwve9
https://prnt.sc/1qhwxjo