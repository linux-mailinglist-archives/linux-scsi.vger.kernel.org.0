Return-Path: <linux-scsi+bounces-3822-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F889300C
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Mar 2024 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1655B20AF3
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Mar 2024 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3088F134CC2;
	Sun, 31 Mar 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNZs60sx"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D874133426
	for <linux-scsi@vger.kernel.org>; Sun, 31 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874710; cv=none; b=YhNBlrkEmiAiE14bAluwB1JmhZEV26A+9szTReuDGIfyU8g5Yiu+2yqZoMOTGtZ5oMZpeXr+iv6X5VcKMq4JiGplY4h/j1RUt4F/WXXfkm+2OelFDYiG4OkYAG/ZU67ya4eOMj5aGUI2Xv7cBj1SPg8WwFJuYHv7hT5CopC9Ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874710; c=relaxed/simple;
	bh=rFl/6jLaFbtBJ+88FvM913PJ4x0vjfjJ4PxyPcL+Huc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anjHM5ALqFmontut6lyKGD3kfYzstCehxfCsQwV7cMxkpBuZ1wqt2AWbFBhrJj7+MZuqM35MG/v6NlQKHeRAtYPzAK4OeTjJ7JmHkRPgh5jRXIijY5C6PdOkQk0kYfS0xHkq9C0p6nPzdcV0ohu6YynV0cBwfaruSEi532nncCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YNZs60sx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3417a3151c5so2154853f8f.1
        for <linux-scsi@vger.kernel.org>; Sun, 31 Mar 2024 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874705; x=1712479505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvtYxn/jBnHDfTZoo9tjjvjwD5frxuJyBUKvJwnL+3s=;
        b=YNZs60sxjS22JN2O7I1e6l4LQcs9rG5hyEwjPdBHiROAQvdiPYBUL76DtenYD3vhRR
         bwIZBD7+KvgIalm0dNt6FGUPS4pDd1Qse4EPor9ap68qx5CN9AhozmiMSDw2FMrLpbeG
         gKnGgUlSwBkBv8EtiS88SnksbuItXCVK6Bk6elij6s+zLocTP1RxVxIlkkj113wvDSvx
         +vUyZMnmqkoG8IdeC+dEWjQ24jRmHubDrnb0w19yuBp0Tbt4PGlo//Ixr+rjhnaZ33TE
         kJG9kl4H+agIYnkhwmXi7TWeqJsUizYoDHcDJeDI0wqBfkCXu6WFwBRcmOrdKMmfS4H2
         nRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874705; x=1712479505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvtYxn/jBnHDfTZoo9tjjvjwD5frxuJyBUKvJwnL+3s=;
        b=OkuEs3G2VjcKt/ZlwZmhF2Vmmg2bussQiKQdQBFOKIDCuvjcfGrev8R71/vX7lZuCP
         lx4/zGXKJyOUZwDEbj5SRiKJhEv1sO3vW5u2J0NWoI+OOyAigeJhABuPZoM38VnKpiP/
         0b8Q+EV/u8gR67IOTBltD6WRI4HCIZnU3AB8WH3y/OtdUa0oum/DDGMqGooQRlRW8HcR
         h51qK8Wi6sKj2r9dVZga+VTFXK6ZHcg3gbx5GGEBcUgzhld8me03E2pPCUxiXP8Ff/gj
         dwBDYMjhvo4GbAZ0A3N0sA8LWCWZZORo3s7fkk56CrMGxaUxKMzffs09JaetwBzc46R8
         9siQ==
X-Forwarded-Encrypted: i=1; AJvYcCW33kftU/wbH0azUPVKv65BHHoUKmngVTm6odjiAjuT4IIdJNtSI0CIMM2UIVXp0Te+zAmVmJP0Ru/BiXUjKYYS6ElO23kZOV+Tjw==
X-Gm-Message-State: AOJu0Yx5HOIz2RGfS8cnGOyjhssUb5V+ecpWaRNUlqihfY2eco5BnGBD
	YLuI56YWBNy5PiDnDqUsz+opfzf2k3PdPPHFd66qu0c8TQKqfo3A3kgmnQxtKyU=
X-Google-Smtp-Source: AGHT+IHDL7qUvlanfXJpum1QutPJwDhfqjnWHrMIeMuLXNRyUdjxIj91RAiue8W9tsSAPEHCGhc6Aw==
X-Received: by 2002:adf:e008:0:b0:341:cfd6:42af with SMTP id s8-20020adfe008000000b00341cfd642afmr4859621wrh.31.1711874704856;
        Sun, 31 Mar 2024 01:45:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:43:55 +0200
Subject: [PATCH v2 08/25] hwrng: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-8-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
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
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
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
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=763;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rFl/6jLaFbtBJ+88FvM913PJ4x0vjfjJ4PxyPcL+Huc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJXrtKjSxEhDjC+L+jnzjTYbfVVvU6xk9d+o
 teur9ZcYz6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiVwAKCRDBN2bmhouD
 18vWD/9VbgZJnWgtc4RTO+pddEkdnkiTVgCduJAzFFrdTMVutBvPmAKiIjAhRDI+a8Un09IPiQh
 aste1QJO7p7fSsZyMBqgnAkPbBRNF+914i4ORlkhllYT6j8TdvLFurf+swTUww1FubuDOoyKts9
 3IYBhK0G/PePT9ybj9PBHD374upe8s6iwPpALGglSB78hEbimgTEzZPTYIVzaSCFbNypvfOo5A1
 3zvxea3c6wu3VzKi0cVux1ZM6W5rowiJwJ0RChKjDGHJpkGKaIhpB3u10SItpaxC4jjT6ydG4ku
 OPnBJNI76koPxFaXD6Z7fmpvzTXYw7Aq1z5O5Vdb3CGQ4ExTWZ18o0cH1KPfCjuCcsEnES8EFCO
 9Dzvn3hAJyYz9JnYMs+4+hRedBTwr1ARhoXSftEW9ElRKNBvdTqwTVpZYA3KN68BYQPh6j98m7o
 BT0AF9Hzsj3GeBTfWRA6cc0j3MQyMMd2qCZmtNEs1mCBi0bxBf9b13/CLibAnxO/AXXds2Dbs2Z
 0ROqHqCOJ1wpwjj70MnWlGzAqkD6Z7YIOSgHQ1T2q+gr+DOLPA9CWLLxNbilOsoOh9wIOuhzMRd
 70e3gCir/B2muC1oT68XzzABQuu2bU4PCKopte4Wbr/04dZjywmaD6GXDiXZRGc2hPIfbSdLXXc
 LUqz7tKsc6Wb1Bw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/char/hw_random/virtio-rng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 7a4b45393acb..dd998f4fe4f2 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -245,7 +245,6 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_rng_driver = {
 	.driver.name =	KBUILD_MODNAME,
-	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtrng_probe,
 	.remove =	virtrng_remove,

-- 
2.34.1


