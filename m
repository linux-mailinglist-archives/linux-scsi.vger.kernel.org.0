Return-Path: <linux-scsi+bounces-528-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4AB804CC2
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 09:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1267AB20C48
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A733D98B
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 08:40:02 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id DAFD99C;
	Tue,  5 Dec 2023 00:28:56 -0800 (PST)
Received: from [172.30.20.54] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id AAD5160626888;
	Tue,  5 Dec 2023 16:28:47 +0800 (CST)
Message-ID: <3d7307c5-0f93-9cef-0cef-34a4cc181d9b@nfschina.com>
Date: Tue, 5 Dec 2023 16:28:47 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/3] scsi: aic7xxx: fix some problem of return value
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <8fb66471-9131-4990-a622-461f5735120f@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/12/5 16:14, Dan Carpenter wrote:
> On Tue, Dec 05, 2023 at 11:33:36AM +0800, Su Hui wrote:
>> On 2023/12/1 15:53, Dan Carpenter wrote:
>>> On Fri, Dec 01, 2023 at 10:59:53AM +0800, Su Hui wrote:
>>>> v2:
>>>>    - fix some problems and split v1 patch into this patch set.(Thanks to
>>>>      Dan)
>>>>
>>>> v1:
>>>>    - https://lore.kernel.org/all/20231130024122.1193324-1-suhui@nfschina.com/
>>>>
>>> Would have been better with Fixes tags probably.  Otherwise, it looks
>>> good to me.
>> Hi, Dan
>>
>> Sorry for the late reply.
>>
>> I'm not sure if it's worth to add Fixes tags.
>> These codes are very old which come from "Linux-2.6.12-rc2".
> I know some people use Fixes tags to point to Linux-2.6.12-rc2 but
> other people don't like it...  Or they didn't like it back in the day,
> I'm not sure now.
>
>> It's seems like a cleanup or improvement.
> It's definitely a Fix.  It affects runtime.
>
>> Umm, should I send v3 patches to add Fixes tags?
> I don't really care, I guess.  Probably yes?  Not a lot of people use
> aic7xxx these days so from a practical perspective it's not super
> important either way.

Got it.  Maybe it's right to omit these old Fixes tags.

Su Hui


