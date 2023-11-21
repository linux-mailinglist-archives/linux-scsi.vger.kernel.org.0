Return-Path: <linux-scsi+bounces-19-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33807F2D69
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 13:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E90E1C20803
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927AF2C9D
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31464192;
	Tue, 21 Nov 2023 04:24:08 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1r5PnQ-0002fg-83; Tue, 21 Nov 2023 13:24:04 +0100
Message-ID: <a3ddbd03-7a94-4b6a-9be1-b268ce883551@leemhuis.info>
Date: Tue, 21 Nov 2023 13:24:02 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scsi regression that after months is still not addressed and now
 bothering 6.1.y users, too
Content-Language: en-US, de-DE
To: John Garry <john.g.garry@oracle.com>, Greg KH
 <gregkh@linuxfoundation.org>, Sagar Biradar <sagar.biradar@microchip.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Hannes Reinecke <hare@suse.de>, scsi <linux-scsi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Gilbert Wu <gilbert.wu@microchip.com>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
 <47e8fd80-3f87-4b87-a875-035e69961392@oracle.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <47e8fd80-3f87-4b87-a875-035e69961392@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700569448;81e4f0a3;
X-HE-SMSGID: 1r5PnQ-0002fg-83

On 21.11.23 12:30, John Garry wrote:
> On 21/11/2023 09:50, Thorsten Leemhuis wrote:
>> Quite a few machines with Adaptec controllers seems to hang for a few
>> tens of seconds to a few minutes before things start to work normally
>> again for a while:
>> https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id=217599__;!!ACWV5N9M2RV99hQ!L26RD0hu99l3f709EFnXU_V7OaB1jG4Hi7BjKvxRuhDWKFmjrgfksLuXA6eBrBCRtOT8JcRRUvzRsHbyEm41r7tL_pbDfw$ 
>> That problem is apparently caused by 9dc704dcc09eae ("scsi: aacraid:
>> Reply queue mapping to CPUs based on IRQ affinity") [v6.4-rc7]. That
>> commit despite a warning of mine to Sasha recently made it into 6.1.53
>> -- and that way apparently recently reached more users recently, as
>> quite a few joined that ticket.
> 
> Is there a full kernel log for this hanging system?
> 
> I can only see snippets in the ticket.
> 
> And what does /sys/class/scsi_host/host*/nr_hw_queues show?

Sorry, I'm just the man-in-the-middle: you need to ask in the ticket, as
 the privacy policy for bugzilla.kernel.org does not allow to CC the
reporters from the ticket here without their consent.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.




