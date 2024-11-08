Return-Path: <linux-scsi+bounces-9709-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDB39C19AF
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Nov 2024 10:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868471F244CC
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Nov 2024 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C0C1E2833;
	Fri,  8 Nov 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4g+M9JO"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB81E2600
	for <linux-scsi@vger.kernel.org>; Fri,  8 Nov 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059906; cv=none; b=pJ/PN8OLVpgB20duIeS11xRI7/gmf2TJ0LhaZmvKK/UtZaPlidlLRQF8PEH6UeChxHccGdoy6E+V0avuNDUoQUSrEcnExX9k/MuK9/Pfw0kRKFmfCNXKk92AXNKgAtHVn/Cz8TVeCX6S8DZ2eGZZfLNc+sQE2p5vw7ifw9K3RGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059906; c=relaxed/simple;
	bh=yyYnt0zeYcifOtxkWb1a/lLSCIHVxKRnsZk+5f+PJTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=po5Rkn6h/U0fJSP8FWZIddOazNkHUfrjSNMqTGVgtmDEOZiERc6P9lHG5wAQVDB3WqjOmx9McDeXIGLV3d/C/1UTI9jJpNtjVGKwncMbUlEfnJxnpu4a8bUfDgwCaWejqxR2EPcaxuPdEUrAj7wD2kavHHjlKdRK9ZIF7BsV2bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I4g+M9JO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso1921998e87.2
        for <linux-scsi@vger.kernel.org>; Fri, 08 Nov 2024 01:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731059901; x=1731664701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5H92Szh7zfoJ1X3k0f3O/M8Kef9HnGfDZM9F62PdTF8=;
        b=I4g+M9JOrF1xRMDWUEXb+hV0tfimai65+InH3ry2IPlAT0QkdpzJ1/j6ZAuyk3/M7g
         QQYVl1HUQXROfyYmkP8WOLaDd+2pnly52JWiF2NaKuX44xxPmSl8hyV6R/XVDtNG3wGU
         i4WQCbln+zJEnXwqEl5Zqmq/YlrHeu0bQy0po6hV3Pqs4TZ7vfsVW+8O0sDyugKhZ09D
         oVx3yGexBkLcsSrYd6Flzzte0UZnaLQ7cHw0YECP2GanbEASaCVSLJuYjUrhlGMAfZwX
         6YdfI4KsC1NRPptpbimRBoRu1DmQ1iVmkr0/cAciRhm0Oow4HpF0O1KihQSdeqoeAwE5
         lGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731059901; x=1731664701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5H92Szh7zfoJ1X3k0f3O/M8Kef9HnGfDZM9F62PdTF8=;
        b=jqsQEClucXBrFGUxYp2yUkp65rc+vct5mIRWDiVehnL+dYCXSmWP92Y0fEnuiNLnVU
         P5iFA1pZOTBcpUVp1vFUbn4qOEQtf7BP2dj4RdTSuFQBD+xDjgjTzkHoLcpB8nzp6saA
         3kPBsPi/oIesOf6Y0w8DyS80EgDWmY3bJ/AisIMLEZnmxi0ASQsLAiEwxoH0KFin4zK4
         dlR7y3yn8jnfooGe5J2JPmJ4Q+K9jNAWHh9J+YtKKic08uacZ3FOPCgKGUEzgb6tAqK0
         fDPJsSp8dD5pwmcz/kA1iFjgasUnkscy1gA3SH2bPrB9vPnRSpTx4tY8uxhL8pLrelay
         j3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNjwCDbc0aooIK/lF2Ghw6TeBwhcFBAO3U7OwjL6+/nYRfz2+dzQK4Af4Yln8MG+bcp6gDN079XC+8@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuZo7uwabt0mKYpAUZX4pmzUeBie5oBW/iYEkDJjuNcm9I7AS
	Rl2V8n9Eb7CII5hYZ7ss/Flltgy6oYSwQ+iouId2gc+ixWQkGyGF7RPhozilXvI=
X-Google-Smtp-Source: AGHT+IFRdqMG06HtkdzkHICdIIWrY7d6GXyCPZ8Qa2uAHGCAECQ9+blFxeuQwDqlNWgVG3erwh8s3g==
X-Received: by 2002:a05:6512:2256:b0:539:905c:15ab with SMTP id 2adb3069b0e04-53d862e3e86mr1089619e87.32.1731059901467;
        Fri, 08 Nov 2024 01:58:21 -0800 (PST)
Received: from [172.20.143.194] ([154.14.63.34])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b05e6042sm57204805e9.44.2024.11.08.01.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:58:21 -0800 (PST)
Message-ID: <fe2f0356-ef90-4fc4-85c1-6a42da209b88@linaro.org>
Date: Fri, 8 Nov 2024 09:58:16 +0000
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] nvmem: core: calculate bin_attribute size
 through bin_size()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Logan Gunthorpe <logang@deltatee.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-mtd@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org
References: <20241103-sysfs-const-bin_attr-v2-0-71110628844c@weissschuh.net>
 <20241103-sysfs-const-bin_attr-v2-4-71110628844c@weissschuh.net>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20241103-sysfs-const-bin_attr-v2-4-71110628844c@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/11/2024 17:03, Thomas Weißschuh wrote:
> Stop abusing the is_bin_visible() callback to calculate the attribute
> size. Instead use the new, dedicated bin_size() one.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
Thanks for the patch,

LGTM.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   drivers/nvmem/core.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 33ffa2aa4c1152398ec66b8dd7b30384c5346a6e..63370c76394ee9b8d514da074779617cef67c311 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -303,11 +303,19 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct nvmem_device *nvmem = to_nvmem_device(dev);
>   
> -	attr->size = nvmem->size;
> -
>   	return nvmem_bin_attr_get_umode(nvmem);
>   }
>   
> +static size_t nvmem_bin_attr_size(struct kobject *kobj,
> +				  const struct bin_attribute *attr,
> +				  int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct nvmem_device *nvmem = to_nvmem_device(dev);
> +
> +	return nvmem->size;
> +}
> +
>   static umode_t nvmem_attr_is_visible(struct kobject *kobj,
>   				     struct attribute *attr, int i)
>   {
> @@ -383,6 +391,7 @@ static const struct attribute_group nvmem_bin_group = {
>   	.bin_attrs	= nvmem_bin_attributes,
>   	.attrs		= nvmem_attrs,
>   	.is_bin_visible = nvmem_bin_attr_is_visible,
> +	.bin_size	= nvmem_bin_attr_size,
>   	.is_visible	= nvmem_attr_is_visible,
>   };
>   
> 

