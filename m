Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E74B6123AE
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Oct 2022 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJ2OSO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 29 Oct 2022 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJ2ORi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 29 Oct 2022 10:17:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1055FAD1
        for <linux-scsi@vger.kernel.org>; Sat, 29 Oct 2022 07:17:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m6so7138989pfb.0
        for <linux-scsi@vger.kernel.org>; Sat, 29 Oct 2022 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpvMghJCmR+gGIw9o+kRim98+XO1f+vARcxfCW900eI=;
        b=yYkL76DgBZx6Rsxi/Ij7SK5aFTqXLyr8YZGbEESvuOrPUHyVHS41Rwf2pOZtswXz7z
         LdLe+ktnRkuSMnbkg+/i2Hd9M5JA3pPtYuqgwrh5KvSGIMfV0xTx1Hj1Bz7nYzA70eB5
         qOy5Srrfl9TMw9D0R22oHirewUnz+uiD0DZp6nnGyfbv/DzdHJ+tuT63EjSQpy9UUb+9
         pMhSU6af+L9KoWoHin2GJdANibYtScE6IKgtshtqMQPY5YF7iUA2kXA2rYw2RqhF3NMR
         Vg5GmOsFaJcvNTQM8HqyQE3qZnC3RQNavPUpM3NXIMrBD6ytPCaz9pbzZwGOAOoykjUP
         wLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpvMghJCmR+gGIw9o+kRim98+XO1f+vARcxfCW900eI=;
        b=wIppefWAcwA+swDyVZ52KM1XM4pbcsdRh66DB8GehM09EwQPtREKV/U8O8lYhAy/Ji
         I8RIQXs6OQ/s0d5ckqxsKRJoXkukmeUIENsjsqTSaDCiyYo+RoSQ7q+U20y9rjPfoabN
         jh/QbHoNCTsOrAnUyFDcjIAE2edKolFwx61iqWIbF60XFa7iN4YmpKzzhYrn9BeYvf+C
         RGuIne/VO+o2zf1chWUcud4fIwgWgU21e+dNrv2u7eImF5rr2PiXKz+zX7th9NcPO72c
         QoXAlgiRTIZabJyULuImv1JrzUdYfmgMWuCirxkvhjO/enlAXZ61fmp0DoxPYtoCh/38
         RT2Q==
X-Gm-Message-State: ACrzQf2RcEnOBfjgBZRq9y3n3aT22r5Tnt4v3yhzMdo/kNUsaekIbFbv
        P1taBJ3tb+iPzYAYxzEMcBxG
X-Google-Smtp-Source: AMsMyM5UyeJR8v0O/g6VCLnIvcYt7DT1bOrRBBnA/htxwCrn3uXpfqP7PUi6J8UKxdSnLBc3vuMVfg==
X-Received: by 2002:a63:d313:0:b0:46b:2ea0:5b68 with SMTP id b19-20020a63d313000000b0046b2ea05b68mr4189259pgg.464.1667053041148;
        Sat, 29 Oct 2022 07:17:21 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.18])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001866049ddb1sm1370157plf.161.2022.10.29.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 07:17:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/15] arm64: dts: qcom: qrb5165-rb5: Add max-gear property to UFS node
Date:   Sat, 29 Oct 2022 19:46:25 +0530
Message-Id: <20221029141633.295650-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
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

Add "max-gear" property to UFS node to specify the maximum gear speed
supported by the UFS device on the RB5 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index bf8077a1cf9a..bdc3b879293f 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1250,6 +1250,7 @@ &uart12 {
 &ufs_mem_hc {
 	status = "okay";
 
+	max-gear = <4>;
 	vcc-supply = <&vreg_l17a_3p0>;
 	vcc-max-microamp = <800000>;
 	vccq-supply = <&vreg_l6a_1p2>;
-- 
2.25.1

