#[allow(unused_imports)]
use crate::matrix_rotate;
use crate::{rotate_clockwise, rotate_counterclockwise};

#[test]
fn rotation() {
    assert!(matrix_rotate((1, 1), 90) == (-1, 1));
    assert!(matrix_rotate((1, 1), 180) == (-1, -1));
    assert!(matrix_rotate((1, 1), 270) == (1, -1));

    assert!(matrix_rotate((1, 1), -90) == (1, -1));
    assert!(matrix_rotate((1, 1), -180) == (-1, -1));
    assert!(matrix_rotate((1, 1), -270) == (-1, 1));

    assert!(matrix_rotate((0, 2), 90) == (-2, 0));
    assert!(matrix_rotate((0, 2), 180) == (0, -2));
    assert!(matrix_rotate((0, 2), 270) == (2, 0));
    assert!(matrix_rotate((0, 2), -90) == (2, 0));
}

#[test]
fn clockwise() {
    let (a, b) = ((3, 2), (-4, 0));
    let (c, d) = ((1, 0), (0, 0));
    assert!(rotate_clockwise(180, a, b) == rotate_counterclockwise(180, a, b));
    assert!(rotate_clockwise(180, a, b) == (-11, -2));

    assert!(rotate_clockwise(90, c, d) == (0, -1));
    assert!(rotate_counterclockwise(90, c, d) == (0, 1));
    assert!(rotate_counterclockwise(270, c, d) == (0, -1));


    // assert!(rotate_clockwise(90, a, b) == dbg!(rotate_counterclockwise(-270, a, b)));
    // assert!(rotate_clockwise(90, a, b) == (-2, -7));
}
