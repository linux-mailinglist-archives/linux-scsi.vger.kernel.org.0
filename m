Return-Path: <linux-scsi+bounces-479-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87331802757
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 21:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C551C20841
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6241CF92
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 20:35:06 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13763A0
	for <linux-scsi@vger.kernel.org>; Sun,  3 Dec 2023 11:50:38 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 5E58314BB90; Sun,  3 Dec 2023 14:50:37 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: bugzilla-daemon@kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [Bug 218198] Suspend/Resume Regression with attached ATA devices
In-Reply-To: <bug-218198-11613-IZUsDxnbCF@https.bugzilla.kernel.org/>
References: <bug-218198-11613@https.bugzilla.kernel.org/>
 <bug-218198-11613-IZUsDxnbCF@https.bugzilla.kernel.org/>
Date: Sun, 03 Dec 2023 14:50:37 -0500
Message-ID: <87y1ebawvm.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bugzilla-daemon@kernel.org writes:

> I guess you need to ask Intel.
>
> I assume that their firmware simply requires the DEVSLP signal to be
> asserted in order to enter lower CPU power states.

I would say it's the hardware that requires the ata link to be powered
down, not the firmware.  They seem to have decided that the way to get
the hardware to power down was to add a new state to ALPM instead of
using runtime pm to actually disable the port.  I would love to hear
from Intel why they went this route.

> If you just send a command to the device, if it not easy for HW logic
> to determine which state is in. It would need to read some registers
> or similar. Sounds way more complex than just having a logic gate.

I'm not quite sure what you are getting at here.  The point of the ATA
SLEEP command is to inform the device that it should power down
everything, including the SATA PHY, and only keep a simple logic gate
active that can detect the big and obvious RESET signal from the host.
It seems to accomplish the same goal as DEVSLP without requiring hacking
in another logic line somewhere that wasn't meant for that purpose.

