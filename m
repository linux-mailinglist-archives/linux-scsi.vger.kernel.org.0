Return-Path: <linux-scsi+bounces-3825-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA0D89302F
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Mar 2024 10:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0141C210AD
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Mar 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7379B9C;
	Sun, 31 Mar 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocupzQuG"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB9137932
	for <linux-scsi@vger.kernel.org>; Sun, 31 Mar 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874722; cv=none; b=eSvt7XyOJwf2RXkmzuSleiMiS5/9bKmsN6D85L2WVzRwafvZ8H17YoffV+w5WlZ7i/C8EAMk365FJEvanvUGIZVaFeK/SISOucdiKJODqycKHnGTHxKFxrwVy6CIQaHequCyDir3lQrj03KcGDJboe1vQepuXD4pOuWg/VRrSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874722; c=relaxed/simple;
	bh=+TTEvPeSyDKzVSSZ0ChnkaU38LId0eko0vuS5jdKWCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIOEiyuspFq6vGxts+BYwg2hOZptQSQfh5RPLej9rAfGVkI14MkVoMH1V5SnETO57D5QwQu0ZQyhGdFE+Ese/WKPTpC/0Ule9aKdm7yAIzV26gnKVSPtqdaR9SKlGq9t/STnttYMMisxjhO+Uwyv8KbQmmrA0mgFIHe5oIMSdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ocupzQuG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-415612da358so1719265e9.0
        for <linux-scsi@vger.kernel.org>; Sun, 31 Mar 2024 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874719; x=1712479519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLTRp2vTdiF6En9+dHZ3QcMOJs6Q2EWbLSRJcvapXSg=;
        b=ocupzQuGAosFuB0p5WzRlVlehfr6mSzHLDOqD64BcJ1Cn0UbubRflZQoKlMgoKIJKr
         mym0EsBg1zlphBj2iMF7YOiv+KnyR2yMsNioCuG7AIApzrbDXbEe9U/P0S1SMiwIMu9J
         s2LpVwJT1+r6B7LCakM/YDfY9SBl+hfvtS5b0UF4SiBXEWksMPe5TOcke5jfdCePVoV7
         T+ZYrgtufRJkWjbjwPBZllS26o3Tt7Zrx8yL45NeNUdTRGxkho6Sf3uzTOcmQ+5wvaCg
         MPAluTOyLBMdtDhe/MjT1TjOomR5iuxU+CdjIQdcBAzuGo74lj0St38bVHuZEQblIstb
         ktOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874719; x=1712479519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLTRp2vTdiF6En9+dHZ3QcMOJs6Q2EWbLSRJcvapXSg=;
        b=J8pf/5THA+CJ0TGqPaf183hiljTMkwBCkKsHbOaqehoDeMVoAlf+vmbecpTX0QAFQ1
         r3hSa1nH33uNWz03fe2GkxlxZsQ1IFkBB3fCMN2UOuAADm8jCFF8ndqNht+S8gach/Ru
         6AA9lOoTKfecb4abq574LcVYXaNC4d4j7EyKKnYBDNuSLtwSsUU4nJqV9sHRP9weOE+N
         y0qUmUUfwkym7cGoOJc3FibNV0OuJR3f0FdOv7CXxPtzkdDulebsjZVB2Q4nyjyriV7P
         da2MLHDZCIEQnaCe8noQthAUeTS7bxrDFihrLA0AK91vuZZZ9lI+5IzpknsVRyODYflU
         +IEA==
X-Forwarded-Encrypted: i=1; AJvYcCVdznRUrD4QXiHtNhFbIy8MweCEJJgQ4T0RncdicIs7BMvodofxbeMFbzOUBsd59oLuoiapv6XZ84e0h/gPlFjRaZo2Ae0g5L6bZA==
X-Gm-Message-State: AOJu0YzkHhfkowM4X41Fnj9xfyy4zBxWxxVfhYM8nlAoFg1cUdcaJ5Ux
	ONIaLJU0VhruCsBOMriii9FH9KcxbAUm+9G+P0dx02Ug9lHSxJikza1k+lOvBqw=
X-Google-Smtp-Source: AGHT+IEPNyzrG9C3csrNqH8eyb70LAbsPxWdsZOAVe+w6F+ieT87UCbeqCljG8/p0+9sLJiIE3zPLw==
X-Received: by 2002:a05:600c:4688:b0:414:63c2:23cc with SMTP id p8-20020a05600c468800b0041463c223ccmr5678340wmo.2.1711874718681;
        Sun, 31 Mar 2024 01:45:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:43:58 +0200
Subject: [PATCH v2 11/25] firmware: arm_scmi: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-11-98f04bfaf46a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=779;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+TTEvPeSyDKzVSSZ0ChnkaU38LId0eko0vuS5jdKWCQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJa5FS1Ky3t5JnGN1NitxgxLomwAmtLXFvfN
 8kf04YQGIeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiWgAKCRDBN2bmhouD
 10a0D/92QZJuTyhvifrg/z2Ow2dHDpsv8gq7Umut3xI+KYc/1ZKUlEDiOmrTkALSfIjl6/7Y5J3
 +YCRV0/q1aiOkNblM9AoDsC899MA0poxb4eT/CRWrpS2igLnISD+hutGurF/0PeMkpTjwVDqtdK
 QAe4gRbabXICA4p8kpjFSKtgIvcJ1rxSAsRQcGtEBDgwmtxzLWqIQrU9jfKdjQDv2wqxRiYJYDH
 y/S1fVkwV6rcC5wxajJi9x0vSP+rgWkEnJjEBFSyYVwa7O1pUeSj8pY0xfxMIa6l7bH4rrB8XH1
 6m5ucB5QnGmITIMRSH7peq2iKn6gWZ/T0zQZ7Kgjx5+n1KeU8+rj67oNBs7vBnlfimTgy6nJB9O
 Q0qtdF+C9DmAIDClmgbsSu96PXxAZyvO+HThDOWutSqH4+A8aEO4Tp2f7uiDyMUWLuVj7SjTdoi
 Cfe9sVx3Hxisr9AFQ68Kgpw+m5LU8f1zorJdB2rvMMZ0y107a5/g3ET+MelenCZgloWJZXV601q
 LpkQY4cqm249iNnZvYp4NX0eECKmmVeTEWg5ARWHzju+WZNSHJhML82qkvSp0AfbFecO9/zOnmn
 fS7n95h5yj52JoAVtZISNHX85xR38NI7TnvFSMXMRwXPa9cH4hPvk1D6bJ63EA005rfNlHugRSz
 fAP/ZxXxQqcGEHA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/firmware/arm_scmi/virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index d68c01cb7aa0..4892058445ce 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -908,7 +908,6 @@ static const struct virtio_device_id id_table[] = {
 
 static struct virtio_driver virtio_scmi_driver = {
 	.driver.name = "scmi-virtio",
-	.driver.owner = THIS_MODULE,
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.id_table = id_table,

-- 
2.34.1


