/*****************************************************************************************************************

This source file implements Plonk circuit gate wires primitive.

*****************************************************************************************************************/

use algebra::bytes::{FromBytes, ToBytes};
use std::io::{Read, Result as IoResult, Write};

pub const COLUMNS: usize = 5;
pub const WIRES: [usize; COLUMNS] = [0, 1, 2, 3, 4];

#[derive(Clone, Copy)]
pub struct Wire {
    pub row: usize,
    pub col: usize,
}

pub type GateWires = [Wire; COLUMNS];

impl ToBytes for Wire {
    #[inline]
    fn write<W: Write>(&self, mut w: W) -> IoResult<()> {
        (self.row as u32).write(&mut w)?;
        (self.col as u32).write(&mut w)?;
        Ok(())
    }
}

impl FromBytes for Wire {
    #[inline]
    fn read<R: Read>(mut r: R) -> IoResult<Self> {
        let row = u32::read(&mut r)? as usize;
        let col = u32::read(&mut r)? as usize;
        Ok(Wire { row, col })
    }
}
