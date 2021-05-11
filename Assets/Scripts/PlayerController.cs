using UnityEngine;
using Sounds;


public class PlayerController
{
    Player _player;
    Movement _movement;
    BattleMechanics _battle;

    CheckpointMananger _checkpointMananger;

    SoundMananger _soundMananger;
    public PlayerController(Player p, Movement m, BattleMechanics b, CheckpointMananger c, SoundMananger s)
    {
        _player = p;
        _movement = m;
        _battle = b;
        _checkpointMananger = c;
        _soundMananger = s;
    }

    public void OnUpdate()
    {
        if (Input.GetKeyDown(KeyCode.Space)) { 
            _movement.Jump();
            _soundMananger.SoundPlay((int)sounds.JUMP);
            }

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
            _soundMananger.SoundPlay((int)sounds.ATTACK);

        }

        if (Input.GetKeyDown(KeyCode.F2)) SaveCheckPoint();
        if (Input.GetKeyDown(KeyCode.F3)) LoadCheckPoint();
    }

    public void SaveCheckPoint()
    {
        _checkpointMananger.SaveCheck();
    }
    public void LoadCheckPoint()
    {
        CheckPoint checktoload = _checkpointMananger.LoadCheck();
        _player.transform.position = checktoload.lastCheck.lastCheckPos;
        _player.transform.rotation = checktoload.lastCheck.lastCheckRot;
    }
}