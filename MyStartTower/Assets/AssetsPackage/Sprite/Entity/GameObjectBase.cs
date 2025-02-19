using UnityEngine;

public class GameObjectBase : MonoBehaviour
{
    public Vector3 Position { get { return transform.position; } set { transform.position = value; } }
    // 其他共有属性，比如速度、大小等（如果需要）

    // 虚拟方法，允许子类重写
    public virtual void OnUpdate() {}
    public virtual void OnCollision(GameObject other) {}
    // ... 其他虚拟方法，根据需求添加
}