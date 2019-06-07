Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 246C83987B
	for <lists+linux-scsi@lfdr.de>; Sat,  8 Jun 2019 00:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfFGWU0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 18:20:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36711 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731132AbfFGWUW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 18:20:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so3033972ljj.3
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jun 2019 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQG5fZ3EhYRq8CYdObUVFyj6seF2R8nq3JkVzFb/lxA=;
        b=J8oCCPGNMQU5rDGmeyVTZPHkWL9+Vc3T20HBnIQsBN/psbfksQVafp9kuniapFnd9p
         ACZqYf29QTVDX3vNf/GeJ+C6SzG9RRzuaNdi7Odo6sI+fOHmjBlRCd8oN2ZfmoLK+yVW
         Z4ijFNknrQ679mE38Nn9tFfqwmhPjVcPgN3CEI1ODVHLd67dZWr89t/5PRBA/eaDKeNz
         imVCpLxet79CIeJKx/Lh38ZyzAatFK0W0vjcsPjXkCGoUOYqKW4hNg+KHhIE7ODa2w80
         vFgRB3icM0W8MLppUf36C40m++FpW5cdTrEZKh9qGz3T7b6fCuVUnjuxS/9bejthZ/14
         6Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQG5fZ3EhYRq8CYdObUVFyj6seF2R8nq3JkVzFb/lxA=;
        b=jW1ghhf9SG1m5pwZba0bKgKO38rru5RtNUIoYtethEbFyBjLCQZFzPtg1jzZFgCEgT
         t5enf/LX57qoCXyUCs+zvxJOzfmXqDy+xVhgTHU4gcXjXPdTNQCxy4BYqwhEs88CstM9
         OslZEgNt9bUCgdVqdhSdS/8L2/YjB1op9f+8u2P1YNZ97+Tly0tNxXWRc5wGB7J9pZPR
         0G03HaqAVbdweItlG3peGa+xwu8EAWxTXlnkTTClwrsXlCzyENpq98OOEJ7cj6PldlsF
         c3vUZihG9ZdpLkuGbEeL0NdNZuhm1yVZnmPsRGPrRVp58GQDlt0pw+pqKuBzEBew+pbS
         bAUg==
X-Gm-Message-State: APjAAAVDUPqYJyd++d/hj1xgjW92FrF2o2fI4df9uQjDsPDsXhb94CNW
        1TUvDojBmdEuaO2PzQ1oD5ZltlnDFM0op2Vev49eSw==
X-Google-Smtp-Source: APXvYqwtFn9ujhL1bNosuQYXIjXabGQeb/hX4swI0JpPVUh1sm9eQAptKaHUcU43LzWRCdPzHPmmw6b84I+/1LdT4jQ=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr5402543ljj.113.1559946020389;
 Fri, 07 Jun 2019 15:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190604072001.9288-1-bjorn.andersson@linaro.org> <20190604072001.9288-4-bjorn.andersson@linaro.org>
In-Reply-To: <20190604072001.9288-4-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:20:12 +0200
Message-ID: <CACRpkdZETzjw2hOz7y15sUFa+s2Ki3UaMh-Qcor4cEopZrf03Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845-mtp: Specify UFS
 device-reset GPIO
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 4, 2019 at 9:20 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> Specify the UFS device-reset gpio, so that the controller will issue a
> reset of the UFS device.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
