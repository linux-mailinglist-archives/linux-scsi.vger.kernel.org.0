Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743D8A5101
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Sep 2019 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfIBIMJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Sep 2019 04:12:09 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37827 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfIBIMI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Sep 2019 04:12:08 -0400
Received: by mail-wr1-f53.google.com with SMTP id z11so12993667wrt.4
        for <linux-scsi@vger.kernel.org>; Mon, 02 Sep 2019 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+mMBfGfyBXwVzvFVVfcxlJch8FPILgIOjN0mMOx57to=;
        b=H7zUbmDNXTLW3eCoCc7zvbS6pobtO0IYx8M00dTL91TOrBJAxIZGE809izxBaeL+mm
         N6GD4bG5Wb9PmZoabAqTdoG0UkXlNDb3FPiRjZ6RW6PEPMZi5vdjl3kEnv4WOzu3KIon
         1WhdOB4PnnWUDZzRiYUAY9X6L6OpOt7NCiI/00yuT3vq3kY7alMlGTEe3wggc8kQ7flz
         DNWnyI5pZBGtGt50e8Ce2bVMNrRRvpNW4UC7XgY2VLbzYT5XPj2aR4F8JMEFDcadVuzW
         5KL9Ch1ayCFK1x5GNp2TYuL21Ke1PgNHgiH6r7SNq107rj7B5mwxIPTAhZ36bTgrZ8ch
         bldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+mMBfGfyBXwVzvFVVfcxlJch8FPILgIOjN0mMOx57to=;
        b=jr7ugO67VRQC9M9Z9oW2CDw4RzJuZUt3eCefiZNPziVmUS/N5Z/ESXkWIsV7j2qHN1
         XB0ZLTMJVRHcrRSA/hET/Mleeq3OSKLmXVOvsFMwFhF6ZndpUyygmObsefcq5SkgMsLW
         k6JAf8y58/QyUDVaVIiXTe32JMR6o9yLECZIRJsYxk58Pw186RDbgy5NtY1vfPXaUiKG
         3Ew7iEDlzpY6ncWasRqY6nmwm9sqh7fRo8kgQcw8UExnvEpwGVpVa+ZdT5YmpNX56DOa
         efnBDBvTkG3Ns0EetR0tF2TSkQV6fXIkCNsICRZOM2blN6Lyee2XPr7JjebpB4q+DYR0
         B+6w==
X-Gm-Message-State: APjAAAVEJ27ELl7qLyv2gM4w03Ygrlks9FxRAQW03SIXvGt70uSkC568
        dfSDrPiVSW06PIpU5THySgTx2A==
X-Google-Smtp-Source: APXvYqywQPyDv6ILjrXdAZAqwfPFaMqdQX4RwwrHVYMZBXzIEVOOyD8h5ALQ0yiiYgcwLnlRdAAGoA==
X-Received: by 2002:a5d:4fc4:: with SMTP id h4mr35018846wrw.64.1567411926634;
        Mon, 02 Sep 2019 01:12:06 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id n12sm19000149wmc.24.2019.09.02.01.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 01:12:06 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:12:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "russianneuromancer@ya.ru" <russianneuromancer@ya.ru>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        SCSI <linux-scsi@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: ufshcd_abort: Device abort task at tag 7
Message-ID: <20190902081204.GO4804@dell>
References: <9f3ed253-5f6b-1893-531d-085f881956dd@free.fr>
 <20190828192031.GN6167@minitux>
 <9257741567170980@myt1-1e65ebab2412.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9257741567170980@myt1-1e65ebab2412.qloud-c.yandex.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 30 Aug 2019, russianneuromancer@ya.ru wrote:

> Hello!
> 
> 
> > I don't remember the exact splats seen, but I would suggest that this is
> > retested after applying the following series:
> >
> > https://lore.kernel.org/linux-arm-msm/20190828191756.24312-1-bjorn.andersson@linaro.org/T/#u
> 
> Turns out this patches is already applied to kernel running on this device, but one line in dts was missing: 
> 
> https://github.com/aarch64-laptops/linux/pull/2
> 
> With this line issue is no longer reproducible with DT boot. Thank you!
> 
> As I understand it's planned to eventually boot this devices via ACPI. 
> 
> @Lee Jones, is my understanding correct?

No, not exactly.  We can boot these devices using ACPI, but with
limited functionality (when compared with booting using DT).  There
are too many black-boxes when booting with ACPI - something that can
only be resolved with Qualcomm's help.

Booting with ACPI helps us to use generic Linux distribution
installers, but it is expected for users to switch to DT once the OS
is installed.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
