Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776EE613CF4
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Oct 2022 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJaSEO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Oct 2022 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJaSDd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Oct 2022 14:03:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF413DCB
        for <linux-scsi@vger.kernel.org>; Mon, 31 Oct 2022 11:03:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g62so11329198pfb.10
        for <linux-scsi@vger.kernel.org>; Mon, 31 Oct 2022 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57hrdpD9V7ZTE8+VIgUybXatzD5HV6GvuzYxuyw9ASk=;
        b=CJZOurchjGJl1snA1fXRSkkVYNfUPtkHRC6arQrhiLHCCHw1eBR+6Q5F0PorDK01ZP
         1Hkzf0fYrm4AGRLhb/l3wfkKVNBgGXpBZz3z3lyNlxt/UHoaR6ON+NVV0OQdlT6f2Yy8
         rPxHeFts4yxmH20dB/LYHEkv1J/BWTk2zsRd48gC341JSYFCkiRixJFJ2HTJAnrC6piJ
         NPg8p6A4d8au8odxHziT895HmhU9L+Oc7GlDTzKYcfTZvdYNg7aAhVRnT/7xzXgXRSdl
         bJY309odjX5XDPSjAt9ir+3anWIHWjKCv5HA/FrmD9Eq5om/RL2latgKPQmGNzOxOzR+
         a7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57hrdpD9V7ZTE8+VIgUybXatzD5HV6GvuzYxuyw9ASk=;
        b=vk2HksTAK0Otaa3b+bx8M9uVA65453cf1o8DNbCVPLirkUrEdwH9J2VozrvPSG89p6
         PVgkwst+VHdVQbCe6+pDx461GoY8YkubbNK9MYWT1h7WUUrOPrmtbWHxLR5Yboo9/IaF
         +kvmdDVzj0+x79IBT9WIQudud4j9OO8zBy90nNOW8AjGakA3G5KuBxOfyjKtep8bX0Ki
         neRwCCR4mXyVeBOqLP5bfOdR9hwSdaaiK0vwTdslih9UPAQiEKMK37R0BaGlCvCf2oyS
         rvU1TxPtEn4z4qXNvMotuliLSBYhXunmlOzyp7/j+rZLEbQw5/+mOYQ+LH9INZSeuQYx
         He5Q==
X-Gm-Message-State: ACrzQf2L7CT4ZkL0A2BtwFcGgL3v9hrRvIYbi9f5+i7F4dOWuboWgptZ
        EbQQ7hGyWOgY2mnTKFH6JcSe
X-Google-Smtp-Source: AMsMyM4YfrwoNrdGfiVoZCqIhrLJ40dbpww+YBMczlctY4waFMDpfmVg0qxipxfjexfRmTW2yYHGGQ==
X-Received: by 2002:a63:2d05:0:b0:460:55e3:df91 with SMTP id t5-20020a632d05000000b0046055e3df91mr13774942pgt.177.1667239410304;
        Mon, 31 Oct 2022 11:03:30 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm4742224plb.26.2022.10.31.11.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:03:29 -0700 (PDT)
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
Subject: [PATCH v2 07/15] arm64: dts: qcom: qrb5165-rb5: Add max-device-gear property to UFS node
Date:   Mon, 31 Oct 2022 23:32:09 +0530
Message-Id: <20221031180217.32512-8-manivannan.sadhasivam@linaro.org>
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

Add "max-device-gear" property to UFS node to specify the maximum gear
speed supported by the UFS device on the RB5 board.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index bf8077a1cf9a..3cb1f48c90f5 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1250,6 +1250,7 @@ &uart12 {
 &ufs_mem_hc {
 	status = "okay";
 
+	max-device-gear = <4>;
 	vcc-supply = <&vreg_l17a_3p0>;
 	vcc-max-microamp = <800000>;
 	vccq-supply = <&vreg_l6a_1p2>;
-- 
2.25.1

