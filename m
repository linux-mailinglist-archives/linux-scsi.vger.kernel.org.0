Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8130188
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 20:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE3SKt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 14:10:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33442 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3SKt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 30 May 2019 14:10:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so4471772pfk.0
        for <linux-scsi@vger.kernel.org>; Thu, 30 May 2019 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eFDoXlDCJDgbvfdMRvzrwYPX6AkCgGx+3FXH/pp4WCI=;
        b=Hj/aSVL+KSKG4ax96YtN3uuLrMs/z61UawRKkpiWTTpOLKBxyl5Zci3eWxEirvaMl0
         n/iXpp/PjU9KkS58jSdzc9vlX2qoO7/rbhV8HMrT8SuVMRoFVOQGo+43nkqgRhkaU9em
         DBX7sL21M4QgZA0azaB7DGgdaFIZK6oWIZOCVPOG1RYOVOgZbg4c9mmopuvBUkqmRMtO
         C6up8kzTV14NvS5SCm/s92rOEbiA5GzqSNLP/VAlXcCkk1QAIGA2WaEX8B/1Xv7ctXTe
         nn4AQ9cDcVJESh0JFsrwYJ+rQapPh/SehRvssegaGiUYtknyRxIsXpnbBXEyZOH4aOXT
         PhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFDoXlDCJDgbvfdMRvzrwYPX6AkCgGx+3FXH/pp4WCI=;
        b=nmvkKLHJnLOR+kbK3Vntyehv7sfL0pyZ5VDQRD/ep6Ew4MFw34Uu/ZdvXjjLIbV1dD
         FfcfKZ29lPWdN1RIJYiFM4o6WEp1eMA2PI/fp0VTbmlinSmLS/hAP4PE3R3lD83QhQwO
         2cVg9iPcxQ86CW1jg3o9XkIhVXslwR8gmfJknQMhcL2vpq/Le9DNttgNyD4Xb5nSho/5
         UoOkaRRKsToL4g59IWbCzpgCY3nFcudUUSlHwaIrsNAnPzmZPzIbAXGu+1O+7fThmLJJ
         CIorVsunMH7GLQU7IKtw4wRYw92sliTj1mCboyAdXht25lC2f1XrfXAbB4pT+Q81I4bS
         SU6A==
X-Gm-Message-State: APjAAAXLQ74aFG9wEVdJssFz7VNgPqMBfk5wRlnh6TVI4NY+n4eUXHjh
        c8+B8/A8g8E8JGnQlHXqmT4=
X-Google-Smtp-Source: APXvYqy25k458K4oZkTOIieR2GrjK2wejfjtDOj7MNpjM1chodzlOxWAHKvgbLcVbshytozoKvoSGw==
X-Received: by 2002:a17:90a:77c4:: with SMTP id e4mr5004113pjs.86.1559239848541;
        Thu, 30 May 2019 11:10:48 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id g15sm3451782pfm.119.2019.05.30.11.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 11:10:47 -0700 (PDT)
Date:   Thu, 30 May 2019 23:40:44 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     David Rientjes <rientjes@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [Patch v2] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL
        linux-kernel@vger.kernel.org
Message-ID: <20190530181044.GA7760@hari-Inspiron-1545>
References: <20190529175851.GA10760@hari-Inspiron-1545>
 <alpine.DEB.2.21.1905291412360.242480@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905291412360.242480@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 29, 2019 at 02:13:18PM -0700, David Rientjes wrote:
> On Wed, 29 May 2019, Hariprasad Kelam wrote:
> 
> > dont acquire lock before calling wd719x_chip_init.
> > 
> > Issue identified by coccicheck
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > -----
> > changes in v1: Replace GFP_KERNEL with GFP_ATOMIC.
> > changes in v2: Call wd719x_chip_init  without lock as suggested
> > 		in review
> 
> Why was host_lock taken here initially?  I assume it's to protect some 
> race in init that leads to an undefined state.

wd719x_chip_init is getting called from wd719x_host_reset
and wd719x_board_found.

In wd719x_board_found case its not acquiring any lock.
In wd719x_host_reset it is called under spin_lock.

Acquiring spin_lock in wd719x_host_reset is there from initial commit
so its better we wont remove this lock.

I think we Patch v1 is  correct fix(pass GFP_ATOMIC instead of GPF_KERNEL )

