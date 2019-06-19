Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17D4B184
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 07:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfFSFm1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 01:42:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfFSFm1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jun 2019 01:42:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so294735wmj.5
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/cpf3zq+TFw4UEIBZS68FxYFecgYH1xkj5zf5lev0W8=;
        b=cCHl/gxL/zXc4WXMsveXwVsU3cxUW+ACFRX97VZSnWNLVolF18pOwLb4cZ5wfy5RnJ
         3REAqJcFK/oGI2QJKcdjOZzJo77brsZ933bk0GZFC6Yb2FeFRu/ZUcdxus4jSMt5QMmv
         cb5mKHlWsJqPkUdz1B5NnEwJWJoHUrL5L43sT51FshRXu6kSGA18KFYUDbdIq3gciajm
         RcT5NEUePlSW1DD27FCL//Db+0LRRjSYEJXPvbTgus3ZYx7ERKnhVKaedqbEpQlbN+J+
         As7P0XNVfOhDqFB3DaVhv4y3AmIyWNhEna4XviYfA0OCDgHVzB72f+z0351/UGM/LxtR
         RG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/cpf3zq+TFw4UEIBZS68FxYFecgYH1xkj5zf5lev0W8=;
        b=i2jETLpBXNFISiCy0tGIvw1/s8nt+nn/h5IqxGYvDeaWbbxb5ONkGqzxwtSeM88FmI
         /xLFzxqNtmbocbeHdRWD2ob9D0aqzR1cLsNef3lILVyACef5uXMoVw5G5owH0zZgo5o9
         po0nLFO/i32FkdqdC9UPT4OxMgNgcHwwXQcssraMLvhTK3PbiA4B8zDetKMxxWWdWOOp
         vpCsBNtEMYv3OHxzDAobAxitEnCE5tZaDSUMYvt9vaS3Su5qj5eQUkmENzdW0eP2PsT5
         JnAgQ8BLbDH5yL2hGxBH1QHZyEi+di+1bEZbGOTnH72V1/WxRaUpNi9V4KI6Yu59i4tt
         2c1A==
X-Gm-Message-State: APjAAAWQj+HUFB6O7j7oon+lP32YTCsSTc+zh0wM2Umqo5L0L8EFIR3G
        1CPHDU8DhpU/frlSloJYsSZGLg==
X-Google-Smtp-Source: APXvYqz1GbEe2qolDZxYNYoUdvQZ5fsE8k6qQo1nlTIumvRmIvonzAOQdnQDSY6CuatAS38KNkwUlw==
X-Received: by 2002:a1c:6c0a:: with SMTP id h10mr6205898wmc.40.1560922945130;
        Tue, 18 Jun 2019 22:42:25 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id u18sm293652wmd.19.2019.06.18.22.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:42:24 -0700 (PDT)
Date:   Wed, 19 Jun 2019 06:42:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     agross@kernel.org, david.brown@linaro.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH 1/1] scsi: ufs-qcom: Add support for platforms booting
 ACPI
Message-ID: <20190619054222.GE18371@dell>
References: <20190617115454.3226-1-lee.jones@linaro.org>
 <yq1zhmeuvst.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1zhmeuvst.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Ard, Martin,

On Tue, 18 Jun 2019, Martin K. Petersen wrote:
> > New Qualcomm AArch64 based laptops are now available which use UFS
> > as their primary data storage medium.  These devices are supplied
> > with ACPI support out of the box.  This patch ensures the Qualcomm
> > UFS driver will be bound when the "QCOM24A5" H/W device is
> > advertised as present.
> 
> Applied to 5.3/scsi-queue. Thanks!

Ideal.  Thanks for your help.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
