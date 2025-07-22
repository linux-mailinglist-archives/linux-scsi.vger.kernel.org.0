Return-Path: <linux-scsi+bounces-15399-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E04B0D606
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Jul 2025 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F08188C016
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Jul 2025 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77592DE1ED;
	Tue, 22 Jul 2025 09:33:02 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B120539A;
	Tue, 22 Jul 2025 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176782; cv=none; b=fPV76YxGw8bxZX5X34/KbyiHvZD4jA5NNUxPLyWBB1MoL7BL2/lY8rcpeyBiSWpb4SohAvSBKwUAKhLSACgc65x1E3j+E4ZUbqto4sFvIbeMeq13fOKuR0uG82+Li+18KkMOMS6pfEHrw7FFH/HaqsIZeArdXDVJXwe0MQAfHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176782; c=relaxed/simple;
	bh=bzjnBXjm6twq36PTMxa4p6fc2/ots6YfYhYwFAMO9eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnyHUgtH2+1zVhJfjjiHc6fd/hLg2TwNP+tF427FkR6USlg4WUdDT9eM37rJ1T/JmWKLhGFy01FknSp+P94sNzzWreglP3yZdQ+kspyCfcwQeo/1u+wenN8hNIiwAgnz0DCFp6+7rsGvheSYHhP4AnAPds2GrDkbR2ukN1Mdo/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id F0BFD431B9;
	Tue, 22 Jul 2025 11:32:57 +0200 (CEST)
Message-ID: <4cb58e56-d9e2-4868-84ad-8b7253148228@proxmox.com>
Date: Tue, 22 Jul 2025 11:32:57 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/19] scsi: detect support for command duration limits
To: Damien Le Moal <dlemoal@kernel.org>, Mira Limbeck
 <m.limbeck@proxmox.com>, Niklas Cassel <nks@flawful.org>,
 Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth patil <chandrakanth.patil@broadcom.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <20230511011356.227789-1-nks@flawful.org>
 <20230511011356.227789-9-nks@flawful.org>
 <3dee186c-285e-4c1c-b879-6445eb2f3edf@proxmox.com>
 <6fb8499a-b5bc-4d41-bf37-32ebdea43e9a@kernel.org>
 <2e7d6a7e-4a82-4da5-ab39-267a7400ca49@proxmox.com>
 <b1d9e928-a7f3-4555-9c0a-5b83ba87a698@kernel.org>
 <a927b51b-1b34-4d4f-9447-d8c559127707@proxmox.com>
 <54e0a717-e9fc-4534-bc27-8bc1ee745048@kernel.org>
 <72bf0fd7-f646-46f7-a2aa-ef815dbfa4e2@proxmox.com>
 <3b2a6cfe-5bf3-4818-8633-c200d8e6f122@kernel.org>
Content-Language: en-US
From: Friedrich Weber <f.weber@proxmox.com>
In-Reply-To: <3b2a6cfe-5bf3-4818-8633-c200d8e6f122@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1753176768826

On 14/07/2025 04:48, Damien Le Moal wrote:
> On 7/10/25 5:41 PM, Friedrich Weber wrote:
>> Thanks for looking into this, it is definitely a strange problem.
>>
>> Considering these drives don't support CDL anyway: Do you think it would
>> be possible to provide an "escape hatch" to disable only the CDL checks
>> (a module parameter?) so hotplug can work for the user again for their
>> device? If I see correctly, disabling just the CDL checks is not
>> possible (without recompiling the kernel) -- scsi_mod.dev_flags can be
>> used to disable RSOC, but I guess that has other unintended consequences
>> too, so a more "targeted" escape hatch would be nice.
> 
> Could you test the attached patch ? That should solve the issue.
> 

Thanks for the patch! The user tested it on top of a 6.15.6 kernel and
with the SAS3008 HBA, and indeed:

- under 6.15.6, hotplug fails with the log messages mentioned in my
first message,
- with your patch on top, hotplug works again.


