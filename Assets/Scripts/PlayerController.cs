using UnityEngine;

public class PlayerController
{
    Player _player;
    Movement _movement;
    BattleMechanics _battle;

    public PlayerController(Player p, Movement m, BattleMechanics b)
    {
        _player = p;
        _movement = m;
        _battle = b;
    }

    public void OnUpdate()
    {
        if (Input.GetKeyDown(KeyCode.Space))
            _movement.Jump();

        float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");

        if (v != 0 || h != 0) {
            _player.GetComponent<Animator>().SetBool("Moving", true);
            _movement.Move(v, h);
        }
        else _player.GetComponent<Animator>().SetBool("Moving", false);



        if (Input.GetKeyDown(KeyCode.G))
        {
            _battle.Attack();
        }
    }
}