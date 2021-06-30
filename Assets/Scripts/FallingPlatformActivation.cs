using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FallingPlatformActivation : MonoBehaviour
{
    public FallingPlatform fallingPlatform;

    /// <summary>
    /// @Author: Robert Juan Ignacio
    /// </summary>
    public void Start()
    {
        EventManager.SubscribeToEvent(EventsType.ACTIVATOR_TRIGGER, ActivateFallingPlatform);
    }
    public void ActivateFallingPlatform(params object[] parameterContainer)
    {
        FallingPlatform fallingPlatform = (FallingPlatform)parameterContainer[0];
        fallingPlatform.Activate();
    }
    public void OnTriggerEnter(Collider other)
    {
        EventManager.TriggerEvent(EventsType.ACTIVATOR_TRIGGER, fallingPlatform);
    }
}
