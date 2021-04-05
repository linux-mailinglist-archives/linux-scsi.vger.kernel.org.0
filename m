Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA19F354683
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Apr 2021 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhDESEW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Apr 2021 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhDESEF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Apr 2021 14:04:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53DDC061756
        for <linux-scsi@vger.kernel.org>; Mon,  5 Apr 2021 11:03:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso3192266wmq.4
        for <linux-scsi@vger.kernel.org>; Mon, 05 Apr 2021 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=AjAn/LNb2u6fS0dE+6rHyhmPgqfB4MEpqPchoCRgmRAJU3fieRN+PLAyLHZ77EzQ2d
         w3erpVeXHapr7/dE+sTMDCzUuqXMvmuPzI3aIO9wke3OyKmX8h8rkkS15pBru2C9N/i1
         k6pUeaBlhyh3mbIB/lcvoqIDXN/2etW2dkqfWcoIwkqLsqJGDK7LcmBXr+6GZp9aG1Mv
         R/MrHlL6KtfhiFqtfLy7c1LWQw6zFJXCjWpnEQnrkjg4Owws7bn4G2No0OtnIMXd00cy
         F1aUsSiFAGwh7Z5Q85snQQCGrpfQEyZaX088zf8CRDPQQPhz9/bI+Wtd71SPMwznxoz4
         HYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=WpCRmgxQ56jGWpEiMj4jUwqRZsq7wkKon9OKSCCv0cFrOiZjbniclBsaRSRiUSrhTI
         eBpTuGV3eqLM8VIlSPcquOUB2c3TLDTB4FFbnTsWUZGvXjrI7UB9AB65g/7sthc0zeD0
         O5ZURF+gh5V+dk346m/JSBG2w6EsNXSB71S687Tnm+GegNFAtZXBQq+GubG8PQmZWdbT
         2AYVskXQ3EKhrDOQjUDa8nk8Uqj81pmwsDJ+REnQLHW+6pKwOmcRinU/GIwbE5uFVA+y
         /9j/cUtuNEvJDwYn5vNjuPWNcxZLS7BsiIzem+uJ8H+at+oun3t99V5/V6QKqhSJjCI8
         f33Q==
X-Gm-Message-State: AOAM530QjYv1TB2Pn/HFN47UT4A0ZgKWFOnpGPZmdPK17M226hXg8LNz
        i1CT5I8yA3dtNeD0VFcXYXg=
X-Google-Smtp-Source: ABdhPJxtGUjIb1PEFDn+eUQsVWASUWXjL5jtW5NgmonVPP6QKCdbcs8+dmCEkJq7FmWN9jiEMGABiQ==
X-Received: by 2002:a1c:6007:: with SMTP id u7mr301161wmb.102.1617645837581;
        Mon, 05 Apr 2021 11:03:57 -0700 (PDT)
Received: from [192.168.1.152] ([102.64.185.200])
        by smtp.gmail.com with ESMTPSA id u9sm263548wmq.30.2021.04.05.11.03.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 05 Apr 2021 11:03:57 -0700 (PDT)
Message-ID: <606b510d.1c69fb81.20eb0.0ab5@mx.google.com>
From:   Vanina curt <odamawussi@gmail.com>
X-Google-Original-From: Vanina curt
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: HI,
To:     Recipients <Vanina@vger.kernel.org>
Date:   Mon, 05 Apr 2021 18:03:45 +0000
Reply-To: curtisvani9008@gmail.com
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

How are you? I'm Vanina. I picked interest in you and I would like to know =
more about you and establish relationship with you. i will wait for your re=
sponse. thank you.
