public class Car extends Vehicle {
    public Car(Decimal speed, Integer occupants, String name, Integer capacity) {
        super(speed,occupants,name, capacity);

        this.SteeringRotation = 0;
        this.TireRotation = 0;

        List<Medium> carMedia = this.getMedia();
        carMedia.add(Medium.LAND);
        this.setMedia(carMedia);
    }

    private Decimal SteeringRotation;
    private Decimal TireRotation;
    private Integer Gear;

    public Decimal getTireRotation() {
        return TireRotation;
    }

    public Decimal getSteeringRotation() {
        return SteeringRotation;
    }

    public Integer getGear() {
        return gear;
    }

    public override void turn(Decimal degree) {
        if (steeringRotation + degree < -1440 || steeringRotation + degree > 1440) {
            throw new IllegalArgumentException('SteeringRotation must be between -1440 and 1440 degrees.');
        }

        steeringRotation += degree;
        tireRotation = (Decimal)(steeringRotation / 16);
        if (tireRotation < -90) {
            tireRotation = -90;
        } else if (tireRotation > 90) {
            tireRotation = 90;
        }
    }

    public override void Accelerate(Decimal amt) {
        super.Accelerate(amt);
        this.gear = (Integer) Math.ceil(0.4444 * Math.sqrt(this.getSpeed()));
    }

}