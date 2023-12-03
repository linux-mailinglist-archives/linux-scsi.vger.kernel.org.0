Return-Path: <linux-scsi+bounces-455-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFD78023C2
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 13:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3611F20F95
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F5014F8E
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SwqzDwrM"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F2F2
	for <linux-scsi@vger.kernel.org>; Sun,  3 Dec 2023 02:36:01 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id 9jnnrzqJl1Jmd9jpQrQmqS; Sun, 03 Dec 2023 11:36:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1701599760;
	bh=7/7K3QF/l4pTTPUL+W/tS/1zgsUPdfiCIZI4+ljPaaU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SwqzDwrMZsvjAF7VbnrUrv+EpGe2clYQRaJ/mJ0dI8OWVyZED+Ok9/h7ps7nCsxrL
	 Cz+xhL48AdOoDn+Pe3Yrj1JuBoOFbCK/r1tDClbBpmYZvJEOfoJpvY7Pr9luQ4FDgI
	 KKUVKmbxwbAg47Qmwh4JQYNZuSYF6XNicEov0YjSXJ+/g0qi6gH4n9ULrt6xV+uqwz
	 xaC5QSgXeFzxxqKJOAkOHFmdthKMayfgo1bVFYbiEISGknPKAs6SBNuEd+n3kGW2DH
	 aoRb4ZrCnlBBQ1afRaGzAvHN3Yrh8h3CAh78SzgYm0JBECkrXcDVnK1m0x0o7P2RQk
	 WLo9hO32IE0fg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Dec 2023 11:36:00 +0100
X-ME-IP: 92.140.202.140
Message-ID: <eb13fc84-d1e8-4121-8569-cf405a35e721@wanadoo.fr>
Date: Sun, 3 Dec 2023 11:36:00 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] scsi: aic7xxx: return negative error codes in
 aic7770_probe()
Content-Language: fr
From: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Su Hui <suhui@nfschina.com>, dan.carpenter@linaro.org, hare@suse.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20231201025955.1584260-1-suhui@nfschina.com>
 <20231201025955.1584260-4-suhui@nfschina.com>
 <87d394e4-e290-41a6-aaf2-92cf6b5ad919@wanadoo.fr>
In-Reply-To: <87d394e4-e290-41a6-aaf2-92cf6b5ad919@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/12/2023 à 11:34, Christophe JAILLET a écrit :
> Le 01/12/2023 à 03:59, Su Hui a écrit :
>> aic7770_config() returns both negative and positive error code.
>> it's better to make aic7770_probe() only return negative error codes.
>>
>> And the previous patch made ahc_linux_register_host() return negative 
>> error
>> codes, which makes sure aic7770_probe() returns negative error codes.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/scsi/aic7xxx/aic7770_osm.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c 
>> b/drivers/scsi/aic7xxx/aic7770_osm.c
>> index bdd177e3d762..a19cdd87c453 100644
>> --- a/drivers/scsi/aic7xxx/aic7770_osm.c
>> +++ b/drivers/scsi/aic7xxx/aic7770_osm.c
>> @@ -87,17 +87,17 @@ aic7770_probe(struct device *dev)
>>       sprintf(buf, "ahc_eisa:%d", eisaBase >> 12);
>>       name = kstrdup(buf, GFP_ATOMIC);
>>       if (name == NULL)
>> -        return (ENOMEM);
>> +        return -ENOMEM;
>>       ahc = ahc_alloc(&aic7xxx_driver_template, name);
>>       if (ahc == NULL)
> 
> Unrelated to your fix, but 'name' is leaking here.

Oups, no, ahc_alloc() handles it.
Really strange API!

CJ

> 
> Also, kasprintf() could be used to avoid buf+sprintf()+kstrdup()
> 
> The GFP_ATOMIC in the allocation could certainly also be just a GFP_KERNEL.
> 
> CJ
> 
>> -        return (ENOMEM);
>> +        return -ENOMEM;
>>       ahc->dev = dev;
>>       error = aic7770_config(ahc, aic7770_ident_table + 
>> edev->id.driver_data,
>>                      eisaBase);
>>       if (error != 0) {
>>           ahc->bsh.ioport = 0;
>>           ahc_free(ahc);
>> -        return (error);
>> +        return error < 0 ? error : -error;
>>       }
>>        dev_set_drvdata(dev, ahc);
> 
> 

