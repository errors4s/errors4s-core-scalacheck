package org.errors4s.circe

import org.errors4s.circe.instances._
import org.errors4s.core._
import io.circe.testing._
import munit._

final class NonEmptyStringLawTests extends DisciplineSuite {
  checkAll("NonEmptyString.CodecLaws", CodecTests[NonEmptyString].codec)
}
