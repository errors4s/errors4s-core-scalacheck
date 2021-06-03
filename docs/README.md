# Errors For Scala Core Scalacheck Instances #

# ScalaDoc #

[The Scaladoc for errors4s-core may be viewed here][javadoc].

[javadoc]: https://www.javadoc.io/doc/org.errors4s/errors4s-core-scalacheck_3/0.1.2/index.html "Scaladoc"

# Overview #

This project provides [Scalacheck][scalacheck] instances ([Arbitrary][scalacheck-arbitrary] and [Cogen][scalacheck-cogen]) for [Errors4s Core][errors4s-core] types.

[scalacheck]: https://github.com/typelevel/scalacheck "Scalacheck"
[scalacheck-arbitrary]: https://www.javadoc.io/doc/org.scalacheck/scalacheck_3/latest/api/org/scalacheck/Arbitrary.html "Scalacheck: Arbitrary"
[scalacheck-cogen]: https://www.javadoc.io/doc/org.scalacheck/scalacheck_3/latest/api/org/scalacheck/Cogen.html "Scalacheck: Cogen"
[errors4s-core]: https://github.com/errors4s/errors4s-core "Errors4s Core"

# Add To Your Build #

Add this to your `libraryDependencies` in your `build.sbt`.

```scala
    "org.errors4s" %% "errors4s-core-scalacheck" % "0.1.2"
```

# Using #

The instances provided here are [orphan][orphan] instances. To use them you need to import the `org.errors4s.core.scalacheck.instances._` package. You will also need to have an underlying implicit [Arbitrary][scalacheck-arbitrary] or [Cogen][scalacheck-cogen] in scope.

```scala
import org.errors4s.core._
import org.errors4s.core.scalacheck.instances._
import org.scalacheck._

<<<<<<< HEAD
val arb: Arbitrary[NonEmptyString] = implicitly[Arbitrary[NonEmptyString]]

val gen: Gen[NonEmptyString] = Arbitrary.arbitrary[NonEmptyString]
=======
NonEmptyString.from("")
// res0: Either[String, NonEmptyString] = Left(Unable to create NonEmptyString from empty string value.)
NonEmptyString.from(null)
// res1: Either[String, NonEmptyString] = Left(Given String value was null. This is not permitted for NonEmptyString values.)
NonEmptyString.from("A non-empty string")
// res2: Either[String, NonEmptyString] = Right(A non-empty string)
```

This is a somewhat cumbersome way to create `NonEmptyString` values, especially if we are using them for error messages. We don't want to always handle the `Left` branch of this `Either` when we are certain we are providing non-empty values.

Thankfully, `NonEmptyString` provides two mechanisms to safely create instances without having to go through `Either` as long as some part of the underlying `String` is known at compile time to be a non-empty literal value. These mechanisms work in **both** Scala 2 and 3.

The first is the `apply` method. This method uses a compile time macro (different ones for Scala 2 and 3) to check that the given `String` is a non-empty literal value. If it is, then it lifts it into a `NonEmptyString` instance, if it isn't then it yields a _compilation error_. For example,

```scala
NonEmptyString("A non-empty string")
// res3: NonEmptyString = A non-empty string
>>>>>>> 2b1c6b7 (Update The Release Script To Use sbt-shell-release)
```

If for some reason you want to customize the underlying [Arbitrary][scalacheck-arbitrary] instance, you can do like this.

```scala
import org.errors4s.core._
import org.errors4s.core.scalacheck.instances._
import org.scalacheck.{Arbitrary, Gen}

<<<<<<< HEAD
implicit val arbString: Arbitrary[String] = Arbitrary(Gen.const("custom non-empty string"))
=======
nes"Invalid port number: ${port}"
// res4: NonEmptyString = Invalid port number: 70000
>>>>>>> 2b1c6b7 (Update The Release Script To Use sbt-shell-release)
```
```scala
<<<<<<< HEAD
Arbitrary.arbitrary[NonEmptyString].sample
// res0: Option[NonEmptyString] = Some("custom non-empty string")

// Or more explicitly
=======
val base: NonEmptyString = NonEmptyString("Invalid port number: ")
// base: NonEmptyString = Invalid port number: 

val value: NonEmptyString = base :+ port.toString
// value: NonEmptyString = Invalid port number: 70000
```
>>>>>>> 2b1c6b7 (Update The Release Script To Use sbt-shell-release)

arbNonEmptyString(arbString).arbitrary.sample
// res1: Option[NonEmptyString] = Some("custom non-empty string")
```

[orphan]: https://wiki.haskell.org/Orphan_instance "Orphan"

# Version Matrix #

<<<<<<< HEAD
This project uses [Package Versioning Policy (PVP)][pvp]. This is to allow long term support (see [this discussion][errors4s-core-pvp]). This table lists the currently supported, upcoming, and recently end of life versions.
=======
```scala
Error.withMessage(nes"An error has occurred")
// res5: Error = Error(primaryErrorMessage = An error has occurred, secondaryErrorMessages = Vector(), causes = Vector())
Error.withMessages(nes"An error has occurred", "It was very bad")
// res6: Error = Error(primaryErrorMessage = An error has occurred, secondaryErrorMessages = Vector(It was very bad), causes = Vector())
Error.withMessagesAndCause(nes"An error has occurred", "It was very bad", Error.withMessage(nes"This was the cause"))
// res7: Error = Error(primaryErrorMessage = An error has occurred, secondaryErrorMessages = Vector(It was very bad), causes = Vector(Error(primaryErrorMessage = This was the cause, secondaryErrorMessages = Vector(), causes = Vector())))
```
>>>>>>> 2b1c6b7 (Update The Release Script To Use sbt-shell-release)

If you need support for a version combination which is not listed here, please open an issue and we will endeavor to add support for it if possible.

<<<<<<< HEAD
|Version|Errors4s Core|Scalacheck Version|Scala 2.11|Scala 2.12|Scala 2.13|Scala 3.0|
|-------|:-----------:|:----------------:|:--------:|:--------:|:--------:|:-------:|
|1.0.x.x|1.0.x.x      |1.15.4            |No        |Yes       |Yes       |Yes      |
=======
```scala
Error.withMessagesAndCause(nes"An error has occurred", "It was very bad", Error.withMessage(nes"This was the cause")).getMessage
// res8: String = Primary Error: An error has occurred, Secondary Errors(It was very bad), Causes(Primary Error: This was the cause)
```
>>>>>>> 2b1c6b7 (Update The Release Script To Use sbt-shell-release)

[pvp]: https://pvp.haskell.org/ "PVP"
[errors4s-core-pvp]: https://github.com/errors4s/errors4s-core#versioning "Errors4s Core: Versioning"
