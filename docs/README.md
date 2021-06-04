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

val arb: Arbitrary[NonEmptyString] = implicitly[Arbitrary[NonEmptyString]]

val gen: Gen[NonEmptyString] = Arbitrary.arbitrary[NonEmptyString]
```

If for some reason you want to customize the underlying [Arbitrary][scalacheck-arbitrary] instance, you can do like this.

```scala
import org.errors4s.core._
import org.errors4s.core.scalacheck.instances._
import org.scalacheck.{Arbitrary, Gen}

implicit val arbString: Arbitrary[String] = Arbitrary(Gen.const("custom non-empty string"))
```
```scala
Arbitrary.arbitrary[NonEmptyString].sample
// res1: Option[NonEmptyString] = Some("custom non-empty string")

// Or more explicitly

arbNonEmptyString(arbString).arbitrary.sample
// res2: Option[NonEmptyString] = Some("custom non-empty string")
```

[orphan]: https://wiki.haskell.org/Orphan_instance "Orphan"

# Version Matrix #

This project uses [Package Versioning Policy (PVP)][pvp]. This is to allow long term support (see [this discussion][errors4s-core-pvp]). This table lists the currently supported, upcoming, and recently end of life versions.

If you need support for a version combination which is not listed here, please open an issue and we will endeavor to add support for it if possible.

|Version|Errors4s Core|Scalacheck Version|Scala 2.11|Scala 2.12|Scala 2.13|Scala 3.0|
|-------|:-----------:|:----------------:|:--------:|:--------:|:--------:|:-------:|
|1.0.x.x|1.0.x.x      |1.x.x (>= 1.15.x) |No        |Yes       |Yes       |Yes      |

The [scalacheck][scalacheck] version is a bit odd in this matrix. This is because [scalacheck][scalacheck] switched to using [semver][semver] during the 1.14.x development cycle (AFAIK).

[pvp]: https://pvp.haskell.org/ "PVP"
[errors4s-core-pvp]: https://github.com/errors4s/errors4s-core#versioning "Errors4s Core: Versioning"
[semver]: https://semver.org/ "Semver"
