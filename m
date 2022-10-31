Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7C613CEC
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Oct 2022 19:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJaSDz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Oct 2022 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiJaSD3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Oct 2022 14:03:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE9F5A0
        for <linux-scsi@vger.kernel.org>; Mon, 31 Oct 2022 11:03:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 20so11366540pgc.5
        for <linux-scsi@vger.kernel.org>; Mon, 31 Oct 2022 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6bI2G8GIEEo0BDFgcfeWu7FnSciJmuXXXHS3QIkOfs=;
        b=GYLJ5dP9svMb4OtR4ddpG8ce6S4fq7m1mFNIV2Ttl46seLZqlFPwVeur7n5+ITO7Zg
         KgqlWPxuwvQ5CGGszgRz4BEOR8YmmcO2+e7aYai4ULMxdjndxV/F7WDcAjmii+2u03ng
         Ksg3Yx0yRUBnaBsk08DyNOKRxkexeJV3QuIjNJsmvBK64fideKnrc2959ouxzz4mNSy0
         E1dsNDvdjTCV8U/JJFK1NtBSppUIjz8Q/zrg3Zw258BkkO2t0IWP1x3tFuYnaQ+ZBDU9
         TV0YDyYvi/rH8MslglzzF+0gNh3JSFCa/h2ffTxJUDH+GkAgV+4KJ7lcmpu7K1Q9jKCu
         yF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6bI2G8GIEEo0BDFgcfeWu7FnSciJmuXXXHS3QIkOfs=;
        b=vw5VRxhVcVTfjREL0Ti4h3j8Tnr+NXawKzTGFgPlvIzkTO4wsDbD9ONTdZazes5+xH
         C2Rvqq61rZi39FRc+h+YjOmbUp4T0BMEyGu2YPR26Us8iKgM/i20YRimmHlAaTUhmpVv
         jlkmBTNYOlQDTD3d12PQfxIUd1O5ZjZvYPfb3AND0gVHgGBpx/9FxtG223/zpbGxmiSj
         imAQgM4lpEyTqQcwf8SMkiGhdOqEjfGJUD3VyEYqGnJwdmUo1htb1zVnn1nJ7q1LV/vl
         DoVQksj4s2GkKknSU6XHAJGtxNIuAPETTbvnad3s848DtY52IJxvbsJZTMMY0iQhFhXb
         HstQ==
X-Gm-Message-State: ACrzQf05ITZjFETKT//ESNf2TdlTMF3vRWrqCjHSlf4rPLt6wztMXdp5
        EAhD4K218UwmGuiFnyVRoe/D
X-Google-Smtp-Source: AMsMyM7eDqp0MAJayBElp6vKNbseMAqO0uaRkOgHaD0JYIbuqiBn6QFTcqJXxhIc+evWMRMYKnLVqw==
X-Received: by 2002:a65:6148:0:b0:458:88cd:f46 with SMTP id o8-20020a656148000000b0045888cd0f46mr13451082pgv.303.1667239402882;
        Mon, 31 Oct 2022 11:03:22 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm4742224plb.26.2022.10.31.11.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:03:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 06/15] dt-bindings: ufs: Add "max-device-gear" property for UFS device
Date:   Mon, 31 Oct 2022 23:32:08 +0530
Message-Id: <20221031180217.32512-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The maximum gear supported by the UFS device can be specified using the
"max-device-gear" property. This allows the UFS controller to configure the
TX/RX gear before starting communication with the UFS device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/ufs/ufs-common.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
index 47a4e9e1a775..5dcd14909ad5 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
+++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
@@ -73,6 +73,11 @@ properties:
     description:
       Specifies max. load that can be drawn from VCCQ2 supply.
 
+  max-device-gear:
+    description:
+      Specifies max. gear the UFS device supports.
+    enum: [1, 2, 3, 4, 5]
+
 dependencies:
   freq-table-hz: [ 'clocks' ]
 
-- 
2.25.1

