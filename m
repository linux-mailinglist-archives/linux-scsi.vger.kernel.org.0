Return-Path: <linux-scsi+bounces-3597-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA69188E5A9
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Mar 2024 15:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618651F2FE69
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Mar 2024 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80821BDBBD;
	Wed, 27 Mar 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJieFn0h"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3B1BDB84
	for <linux-scsi@vger.kernel.org>; Wed, 27 Mar 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543583; cv=none; b=kCwLP/oGG8UELRwjPP5qB1AfmIyNh2hwuiUSxziwECghCzo22kut2mbiMZYmoyOD+SkdGZua01Euu60Kuh66aw0p0dD+S8JVok5Vca+1BTtPhSSgSSA2+Lh686gvoZmtO4T05o7wc5ApY2eyIIid3Cef3OogFJ4nIwfFDqf1d5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543583; c=relaxed/simple;
	bh=JcKhWFch83brhdG0VtzetHVJQ40R24YKIvpYHZtTLn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfSC79uj+fZrwiqHlWcEDRsGOC3FX1ejgwEGHs3FzUYZkwnkNY/Xdy1F5v+IDiThjMMtRzF+T0f7Bl4hlhTgRhzMHOVHXY8sedZY9RGA1PMoydpyCGY3DJQYhW3cwvw0Do4V1nTi/VhhzaAX4K87UKV1UxZzQ15WIsmOhsZxweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJieFn0h; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c2b4850d2so2155806a12.2
        for <linux-scsi@vger.kernel.org>; Wed, 27 Mar 2024 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543578; x=1712148378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTHQAQAXVP2yHTVyN3Qf81PY6hYlRsflmkOJj4KRX5A=;
        b=rJieFn0hbgjOUFXBDnMtc3gi7yiRt0nTBUY8RN8ULF0Sl23bgfuPf+C9JQuODFfijb
         jb5MykVChsIQheuU1/1aaAxUbZWcJVvancIWT7QI3DPj9NZdE182X2iSoBtw1FBirO19
         kNrWeoi/X30Nm10iDJO+VQM/3dOuqY7+FRF8fcAc2+UgwCD0IKi64AChmmBCWUgUVfG/
         ImSKiokzIZ7yIutnTQjUWRMRrt2QhGrP6KGDBYNLumek4H/M3UYvYDzHiO73WPRV2nF7
         GQ4pU4kdO7+3uTFQPCfm28IZrTkpyeZVPkCYkTL8/JPv4p8bJ1Gxuz2eo9050g7VpGMl
         a29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543578; x=1712148378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTHQAQAXVP2yHTVyN3Qf81PY6hYlRsflmkOJj4KRX5A=;
        b=IFbQeN9hboyXHh4dSeUg94H4MeV6ssDTTU7OTXUBywa2PTogeeFBM00koR2T8HUjaZ
         CuSBKPIvfi1EMt5Q/fyBuPwDrbvOPzoq4hWxDB4FYZt4662zuwdV5NVwrCYZgvijdjat
         xajUk8yxf+9jVCssGrUPAGSSodOwK5Ry3Fkr3nTWyt6BB1gsTaP58UlCs4WXXWYRvk8g
         RPLU9CMsU/gaAFS8A3WJdsIKbuRE/BoBPoIRKDeZyMXY33gnGCQL303K1aLWfYtsxe2x
         j+syqc3f/U6vtp92okolpe5qjuN2AjIvGUQwPArYXPK/FmsluRP4XdJeoXLnF7qrJ2YH
         w2eA==
X-Forwarded-Encrypted: i=1; AJvYcCWCqrXVnUhEwRZBcSinf/RxsGJNEoqcc9dZxFQ29/mrI8Dq3JyiWhyjVE3vIW99S3k1PNUHCNCGsL4if0IVCvK/i/1SOlaHHvf/ag==
X-Gm-Message-State: AOJu0YwC1JfFDfl2VjR6mfzbbIlC0fw5dPEYz4PLmRrnnTKXyT6ukZFm
	7izFj/jB5OO1HfUwMKrAIbfERVMn24W9HIokl/1RmlzGmbuM9UcvNX++zMvZTrM=
X-Google-Smtp-Source: AGHT+IFX9TzVkfreMFnggYGMLSIMwa6TdcWtnATIFoctKTDk56r9dBF2wj2yYQDj0kzNPmIK0zouXA==
X-Received: by 2002:a17:906:4542:b0:a4d:ff5f:98ad with SMTP id s2-20020a170906454200b00a4dff5f98admr1560710ejq.37.1711543578195;
        Wed, 27 Mar 2024 05:46:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:46:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:08 +0100
Subject: [PATCH 15/22] net: 9p: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-15-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=719;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JcKhWFch83brhdG0VtzetHVJQ40R24YKIvpYHZtTLn8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPn2yRXyBXkq6ACxK8eFxLTG7R9tVOB7uD/Y
 7v9Elz1TnyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT5wAKCRDBN2bmhouD
 15k2D/9hVir7j0TqughjehMP7EZCDouF1HvdZ3+c7KMqYHSlkKGrnvjzwyfCDv3RlZhh+e4FdHm
 X+s2MAMJ3/85Ly02t4joZHI5QfXytoQo4wwpxxtkpRJN5HiVm/rzZcXsccHZKIRcYWz1PH1N/38
 fm3Bxvy+ZnHsCGiSHZsM4PqLa6T9KeFlpqp++ZsNra60QDqFbPqgVbY7+kqLkwM0/AUsGpG5KH+
 fANSzGGe28ClqfxLt1Vu4U8CSlWj7o3ElcC/D1XBCweTqRPcA+2iLe7qUDmhal7tLZX6ScveM68
 DfAmPWnA9tNLgNUIX4SkzIHy5muQ2Carr3j/RrrZpNNVOt5Rb7NUnfq4S2bZNQmiGMtu/X7CDDx
 YJi/1RGHGSqYKlxD5AR9Ez4RoFG35FAuZUI8gO/AbAvW4cJ75x77zX3gQSCjiiqhn9mLgzwLmDE
 1oKNZb8RoXjYMGAXa4ZRkn76LzMcWV5/Bt2t+04gDUOR8V1oiQqStsdHKtr1HJO9N86cbbk05le
 RrseGA2RFkzWlx0/Wu+TgsVFtHEwAqu5ZP8LQMSd/i+S9ZdwaO77JXqExIP7SpKvQP8EPSlg574
 lkdW0kb9S1N7OPFwSIwHgZjvg2eSitp5mVOTWd2Cs0lm+avAC5JESLW0CvDV6P34723ld4sdEDl
 LSIrKL+jjHKKMPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 net/9p/trans_virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index e305071eb7b8..0b8086f58ad5 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -781,7 +781,6 @@ static struct virtio_driver p9_virtio_drv = {
 	.feature_table  = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name    = KBUILD_MODNAME,
-	.driver.owner	= THIS_MODULE,
 	.id_table	= id_table,
 	.probe		= p9_virtio_probe,
 	.remove		= p9_virtio_remove,

-- 
2.34.1


