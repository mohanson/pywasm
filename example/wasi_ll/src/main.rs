fn main() -> Result<(), Box<dyn std::error::Error>> {
    for e in std::fs::read_dir("pywasm")? {
        let e = e?;
        let s = std::fs::metadata(&e.path())?;
        println!("{:?} {:6?} {}", s.permissions(), s.len(), e.path().to_str().unwrap())
    }
    Ok(())
}
