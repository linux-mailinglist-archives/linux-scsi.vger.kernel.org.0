Return-Path: <linux-scsi+bounces-23-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5777F318B
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 15:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB63C282F56
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864EB46548
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Nov 2023 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B81BB;
	Tue, 21 Nov 2023 05:24:58 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1r5QkG-0006kS-5Y; Tue, 21 Nov 2023 14:24:52 +0100
Message-ID: <fe89fd29-562c-46c0-9a15-e3a5c43da9a1@leemhuis.info>
Date: Tue, 21 Nov 2023 14:24:50 +0100
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
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 John Garry <john.g.garry@oracle.com>, Greg KH <gregkh@linuxfoundation.org>,
 Sagar Biradar <sagar.biradar@microchip.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 scsi <linux-scsi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Gilbert Wu <gilbert.wu@microchip.com>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
 <47e8fd80-3f87-4b87-a875-035e69961392@oracle.com>
 <a3ddbd03-7a94-4b6a-9be1-b268ce883551@leemhuis.info>
 <18b3745d3e5de2ffd9b74f9cc826c2c3235dc6ca.camel@HansenPartnership.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <18b3745d3e5de2ffd9b74f9cc826c2c3235dc6ca.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700573098;7592b915;
X-HE-SMSGID: 1r5QkG-0006kS-5Y

On 21.11.23 14:05, James Bottomley wrote:
> On Tue, 2023-11-21 at 13:24 +0100, Linux regression tracking (Thorsten
> Leemhuis) wrote:
>> On 21.11.23 12:30, John Garry wrote:
> [...]
>>> Is there a full kernel log for this hanging system?
>>> I can only see snippets in the ticket.
>>> And what does /sys/class/scsi_host/host*/nr_hw_queues show?
>>
>> Sorry, I'm just the man-in-the-middle: you need to ask in the ticket,
>> as  the privacy policy for bugzilla.kernel.org does not allow to CC
>> the reporters from the ticket here without their consent.
> 
> How did you arrive at that conclusion?

To quote https://bugzilla.kernel.org/createaccount.cgi:
"""
Note that your email address will never be displayed to logged out
users. Only registered users will be able to see it.
"""

Not sure since when it's there. Maybe it was added due to EU GDPR?
Konstantin should know. But for me that's enough to not CC people. I
even heard from one well known kernel developer that his company got a
GDPR complaint because he had mentioning the reporters name and email
address in a Reported-by: tag.

Side note: bugbot afaics can solve the initial problem (e.g. interact
with reporters in bugzilla by mail without exposing their email
address). But to use bugbot one *afaik* still has to reassign a ticket
to a specific product and component in bugzilla. Some subsystem
maintainers don't want that, as that issues then does not show up in the
usual queries.

Ciao, Thorsten

