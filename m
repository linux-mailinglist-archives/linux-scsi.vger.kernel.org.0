Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AD53C8182
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Jul 2021 11:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhGNJ1G (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Jul 2021 05:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhGNJ1G (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Jul 2021 05:27:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E7C06175F
        for <linux-scsi@vger.kernel.org>; Wed, 14 Jul 2021 02:24:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k4so2323576wrc.8
        for <linux-scsi@vger.kernel.org>; Wed, 14 Jul 2021 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=g3BAKPjHetFBZtzHXYHLAPmVbhMCl0VTaJxXOkwZEDg=;
        b=edSTyJljs3Kxh+Z/XgzZytiHAR3c6FaEEeDHHCSRKCyoeacekjiNrkvXoZvO3eBGD3
         /4NGrxYhkuxnHnEEwmT/Ddc47eoiJPm7jLcVHZZtYv4hjFkMOQ+x7sWeXCQ/PHExveWM
         2cLGugj31fLB0zWW8sATlAzkTbmhom7fdelbIpkmXCxNt2Bcsj/r1afx2POxDuIVLZ/B
         +dFx1HiLOg9lxBsRSlLf3+/s7Ns0v7wTe8+NwAU6x1W/CFFWANxN2eJoYo1SUfQVZLYT
         coeUq9QA/vTgaNLHHOEJWfmC6kkvHwGc63fk8VS2ud/ZnugGGXUZRuCapBfdvvpy5dSV
         wA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=g3BAKPjHetFBZtzHXYHLAPmVbhMCl0VTaJxXOkwZEDg=;
        b=OlDlzYRyatBEECCCGsptB9ol701oL/UBFgtOyAIXaYHLthk4e/yIjAjNc3RCx4O7Et
         hgzzQ8BQrh8JrJU6HZ27iSDvhJCjpXZb2HBtBUDT8CheKg2nMawYxTl2i8HfVM0ITShC
         I6VdZE/37kjjYu4dRqZj5tFBibT8vucP1FbMQqX7rERIEjBoQZePb0WwwnJ7FdYVpxM7
         M3ZIoGFwHvH1eZ+ptPrtNONk+dpt1ep2etXAUfguE997SACz1QNf91LJe/cU5g4Bemt4
         8nK7SV/lsp9b5Uvw8glCOaBDex3MIfRps1MfgGUa2P2gHsGQIMICLO1GBC9dEevHw6oJ
         5lQg==
X-Gm-Message-State: AOAM533sJGHuZgeojyHEiExlfkZA+sSYS9JB2f1SwOejrSuYR8N/t5j4
        Xn6SNC8av7HL+YIop1AuvS0=
X-Google-Smtp-Source: ABdhPJwIzu8mrKnlLYcjMVFGTSmyrzI8kdq944d8fBVIsB71V/16GI07g7p8E3TGsdf5Gkm/qublvw==
X-Received: by 2002:a5d:5103:: with SMTP id s3mr11353014wrt.180.1626254652456;
        Wed, 14 Jul 2021 02:24:12 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec65.dynamic.kabel-deutschland.de. [95.91.236.101])
        by smtp.googlemail.com with ESMTPSA id o11sm4935603wmc.2.2021.07.14.02.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:24:12 -0700 (PDT)
Message-ID: <571b3251ed5b09d26c78a20e32e8174f2f582309.camel@gmail.com>
Subject: Re: [PATCH v2 02/19] scsi: ufs: Reduce power management code
 duplication
From:   Bean Huo <huobean@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bean Huo <beanhuo@micron.com>, Yue Hu <huyue2@yulong.com>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>
Date:   Wed, 14 Jul 2021 11:24:10 +0200
In-Reply-To: <20210709202638.9480-4-bvanassche@acm.org>
References: <20210709202638.9480-1-bvanassche@acm.org>
         <20210709202638.9480-4-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 2021-07-09 at 13:26 -0700, Bart Van Assche wrote:
> Move the dev_get_drvdata() calls into the ufshcd_{system,runtime}_*()
> 
> functions. Remove ufshcd_runtime_idle() since it is empty. This patch
> 
> does not change any functionality.
> 
> 
> 
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> 
> Cc: Stanley Chu <stanley.chu@mediatek.com>
> 
> Cc: Can Guo <cang@codeaurora.org>
> 
> Cc: Asutosh Das <asutoshd@codeaurora.org>
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>

