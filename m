Return-Path: <linux-scsi+bounces-310-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004FE7FE12D
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 21:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE18028242F
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A77640C05
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30E198;
	Wed, 29 Nov 2023 10:47:16 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 3C1E014B221; Wed, 29 Nov 2023 13:47:16 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Niklas Cassel <Niklas.Cassel@wdc.com>, "bugzilla-daemon@kernel.org"
 <bugzilla-daemon@kernel.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Damien Le Moal
 <dlemoal@kernel.org>
Subject: Re: [Bug 218198] Suspend/Resume Regression with attached ATA devices
In-Reply-To: <ZWcVhXMbJOEHIq0D@x1-carbon>
References: <bug-218198-11613@https.bugzilla.kernel.org/>
 <bug-218198-11613-NAsEdarpyZ@https.bugzilla.kernel.org/>
 <ZWcVhXMbJOEHIq0D@x1-carbon>
Date: Wed, 29 Nov 2023 13:47:16 -0500
Message-ID: <87zfywv1l7.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Niklas Cassel <Niklas.Cassel@wdc.com> writes:

> The reason why many platforms do this override, is because:
> "One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend."
>
> "SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
> user has to either use scsi-host sysfs or tools like powertop to set
> the sata-host link_power_management_policy to min_power."

What?  I'm confused.  Here are several things that come to mind that
when taken together with this statement confuse me.  Perhaps I am wrong
about one or more of them?

1)  DEVSLP is an odd thing they invented to have ACPI twiggle a GPIO bit
to cut the power rails to CDROM drives that aren't in active use.

2)  SATA ALPM has the SATA controller automatically transition the sata
link to lower power states when it isn't being used, and back again on
use.

3)  The SATA controller can not be suspended until all of its ports are
suspended.

4)  Suspending a SATA port does not happen during ALPM, but rather only
either during system suspend, or when you enable runtime pm on the disk
and the ata port in sysfs ( both are disabled by default ).

A quick google led me to this: https://smarthdd.com/device_sleep.htm

Which indicates that this DEVSLP thing is now being used to send an OOB
signal to a SATA SSD so that it can power down its PHY completely, but
isn't that what ATA SLEEP is for?  aka. hdparm -Y.  That command tells
the drive that it can power down its PHY and then the host can power
down its PHY and it takes a sata link reset to wake the drive back up.
The link reset is easy to detect with minimum circuitry that is far
simpler than the full sata PHY.

It sounds like somebody decided to hack an OOB signal into ALPM rather
than use ATA SLEEP, but why?

