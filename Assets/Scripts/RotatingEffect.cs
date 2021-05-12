using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotatingEffect : MonoBehaviour
{
    Animation Anim;
    // Start is called before the first frame update
    void Start()
    {
        Anim = this.GetComponent<Animation>();
    }

    public void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.tag == "PlayerAttack")
        {
            //Anim.SetTrigger("Rotation Active");
            Anim.Play("rotationActive");
        }
    }
}
