Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8E352A8
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFDWUP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 18:20:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33540 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFDWUO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 18:20:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so3748233pfq.0
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7CFZoy+tTyBgH/Y1DK4S3S5eb/9dJPHIxDl6yCqA2lc=;
        b=wGl1C6BaETLmX90w/Z9x0H6LCrbUNoRHAk16TGpmlimLNRWI4t2oIKOB1Y86ONZpcZ
         J8OB+vLJmS1Mb4CArjMvtfxkPSLGlYaktxEE2U/sTnLItcyqpCaqXqy+zXyoB5esPKaB
         JRhEkxwMEtSwQ0XinLktQ4Q4ZeXLRgAFltcmXcYmcLW1o/sBRKp9+Zfbfn8NozqaTbvp
         lrXySHvNNqlM+QjEAjInFTmyXjJQzfr0pnoQvZLaBpZntWeHdrvC4YPoTXW9BzLs4qy5
         Bt94TadtVNrxVz8X53dcM3dRC67THeAvHx5rKGWcyi9AnS0rbTm6Fu3BQmn8Rxgm6UlY
         6dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7CFZoy+tTyBgH/Y1DK4S3S5eb/9dJPHIxDl6yCqA2lc=;
        b=pQKxm+QpeONsWBzWLaglsuG6KpcLpG2w500B2Xegw5g2VlCOSqLVtaNb95jMWNWagd
         WBqyv6sp5RtrhnJFlkPUsg4FJU0oPa7DF6yjqoi8bRHRh7lkEuq5SJ9iMdQZIW6jAKww
         cDWnAyFZwPgAzb6cyiY1Ck0dhwnhOd4pBeK8CE1vU1u1SOu++UJIof2Nwq/XhavNpNQ/
         KY7gUm7/Wf4Lk1WSYCALcl2myiAiikyvEn3SIea8XVqv5ZeONW2jjHxVbNmcb7BSdkPO
         8HfsX2Oo9lgiCsmBqpvEsiqaIy6oESzNx0C7MTWUaZ6cFU2b5ZcuzlzwX7Z98p7Dg9Si
         83ew==
X-Gm-Message-State: APjAAAWKgsiJdDlx0o2BiNxO27zq7Yz+GD65DsxC9J3X2tNi0twohCFW
        Jd6qvMazJlz80cxdlbeV/AvSKA==
X-Google-Smtp-Source: APXvYqxaPHQnOhvSxbkY4qQfhowzEMFVQJ1lvqNAsaIeP42lRvH3mxOWeGwz1aLz4U+eQ3shD8zFqg==
X-Received: by 2002:a17:90a:d3d2:: with SMTP id d18mr4539501pjw.5.1559686813764;
        Tue, 04 Jun 2019 15:20:13 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u20sm7717211pga.82.2019.06.04.15.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 15:20:13 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:20:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/3] scsi: ufs: Allow resetting the UFS device
Message-ID: <20190604222010.GC4814@minitux>
References: <20190604072001.9288-1-bjorn.andersson@linaro.org>
 <20190604072001.9288-3-bjorn.andersson@linaro.org>
 <5cf68d5b.1c69fb81.281cd.5f93@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf68d5b.1c69fb81.281cd.5f93@mx.google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue 04 Jun 08:25 PDT 2019, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2019-06-04 00:20:00)
> > @@ -6104,6 +6105,25 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
> >         return err;
> >  }
> >  
> > +/**
> > + ufshcd_device_reset() - toggle the (optional) device reset line
> > + * @hba: per-adapter instance
> > + *
> > + * Toggles the (optional) reset line to reset the attached device.
> > + */
> > +static void ufshcd_device_reset(struct ufs_hba *hba)
> > +{
> > +       /*
> > +        * The USB device shall detect reset pulses of 1us, sleep for 10us to
> 
> This isn't usb though.

No, it is not.

> Can we have a gpio reset driver and then
> implement this in the reset framework instead? Or did that not work out
> for some reason?
> 

The reset DT binding document clearly describes that resets are for
chip-internal resets, and this is a general purpose (output-only) pad on
the SoC that's connected to the reset pin on the UFS memory.

I actually see nothing preventing you to connect said reset pin to any
other GPIO.

Regards,
Bjorn

> > +        * be on the safe side.
> > +        */
> > +       gpiod_set_value_cansleep(hba->device_reset, 1);
> > +       usleep_range(10, 15);
> > +
> > +       gpiod_set_value_cansleep(hba->device_reset, 0);
> > +       usleep_range(10, 15);
> > +}
> > +
> >  /**
> >   * ufshcd_host_reset_and_restore - reset and restore host controller
> >   * @hba: per-adapter instance
