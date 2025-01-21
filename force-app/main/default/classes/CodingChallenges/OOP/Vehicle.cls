public abstract class Vehicle {
    public Vehicle() {
        //Random Default Values
        this.Speed = 0;
        this.Occupants = 0;
        this.Name = 'Default';
        this.Capacity = 1;
    }

    public Vehicle(Decimal speed, Integer occupants, String name, Integer capacity) {
        this.Speed = speed;
        this.Occupants = occupants;
        this.Name = name;
        this.Capacity = capacity;
    }

    public enum Medium {
        LAND, AIR, WATER
    }

    private Decimal Speed;
    public Decimal getSpeed() {
        return Speed;
    }

    private String Name;
    public String getName() {
        return Name;
    }

    private Integer Occupants;
    public Integer getOccupants() {
        return Occupants;
    }

    private final Integer Capacity;
    public Integer getCapacity() {
        return Capacity;
    }

    private List<Medium> Media = new List<Medium>();
    public virtual List<Medium> getMedia() {
        return Media;
    }
    protected void setMedia(List<Medium> newMedia) {
        Media = newMedia;
    }

    public virtual void Accelerate(Decimal amt) {
        Speed += amt;
    }

    public abstract void turn(Decimal turn);

    public override String toString() {
        return 'Speed' + Speed + 'Media' + Media + 'Name' + Name + 'Occupants' + Occupants;
    }

}