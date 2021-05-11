using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShieldPot : Collectable
{
    public int shield = 15;
    public override void DarStats(Collider other)
    {
        other.gameObject.GetComponent<ICollector>().GetShield(this.shield);

    }
}
