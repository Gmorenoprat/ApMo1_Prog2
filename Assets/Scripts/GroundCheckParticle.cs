using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundCheckParticle : MonoBehaviour
{
    [SerializeField]
    public GameObject dust_particle;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Floor")
        {
            Instantiate(dust_particle, transform.position, dust_particle.transform.rotation);
        }
    }
}
