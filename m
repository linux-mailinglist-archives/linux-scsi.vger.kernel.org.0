Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D66F255E1D
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Aug 2020 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgH1Pqa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Aug 2020 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgH1Pq2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Aug 2020 11:46:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B26C061264;
        Fri, 28 Aug 2020 08:46:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t2so1376993wma.0;
        Fri, 28 Aug 2020 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Aqq6rPsX+W7iIliHjghmhHUibKq8+l+/BXXT8k2vJoI=;
        b=bfkjdGZNtR3X0fbFjilpa02iQ+bbO3tkdlQwoa52bJIGiIOVmQhkd5fAOsAfgbwI5y
         yQ8YOepKd5ahX8Hb2uA/iu0/xb6jSsFym00buPQkPU46bAE8v+1kr8j6N6qD+S+BCbvl
         IV+cthw/LTz91yXb3RYJhyGqhCc6MGEUhTYKtYBiFweESqIse0fFTZB9GKSrzeYXFpY+
         jizFlnR8wTFjDVbGsBETR87L+cMWOv4byksNEJhG4T39Z8kW1U7dbS2kk/Hdzn1TRqzD
         WWxOnyUU1sLtkYTUXwvHr+0iziGSDQuhx0olOEDr4JEPUSy2XBsHgIkmmhDebLy1vR0B
         OrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Aqq6rPsX+W7iIliHjghmhHUibKq8+l+/BXXT8k2vJoI=;
        b=MZmCxhF3hY3dwM88Qt7E4qSLyq9MH8nStfw8ETf0i865Wu1MaQntyRaWRUhp1Sj1kx
         0RrF5JAPkjvqDGvZAq9JbpzDz6h+0a7pwzNHkY3c0jdb1s4xVbLxXT1A0xV5MjlwL6Ea
         hw/MikUSy2Run5J/isf5pPImqOoWI1Ep3kYnHxHArPi7VZHOMPzTbAS5hdM+ZYqfIliI
         bc8NmX4fZFdez+QAnUlIZh1kdF7nM9Vp4YbZsWhKrZ/8fSPY2kgOz0P8YjQXAWkuxEgC
         V+jFTvubFkCUCkX5xOHieo4N2PRF/643JbJj/i3R7SWu0HS/OkvyBAJjoZtcK86bvF5r
         bzsA==
X-Gm-Message-State: AOAM532u+UGZ+67S9JMBAfbSk6OVzmF5YPC6PDP1xM01uuvCVqfnec0N
        wrap1yO7qfWLvqiQiVIvEcWlWE/Bo77KHbN4
X-Google-Smtp-Source: ABdhPJz/gCyVAUjyyOAcncSR0LIOX8MlP5uO0ndSzpSxgTiQyq1SHLD6S2TvvQbdHTSPBTY7o8wb+w==
X-Received: by 2002:a1c:ab55:: with SMTP id u82mr2228964wme.139.1598629585772;
        Fri, 28 Aug 2020 08:46:25 -0700 (PDT)
Received: from felia ([2001:16b8:2d94:4000:f807:c6f3:919:9c25])
        by smtp.gmail.com with ESMTPSA id 70sm3082258wme.15.2020.08.28.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:46:24 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 28 Aug 2020 17:46:19 +0200 (CEST)
X-X-Sender: lukas@felia
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com,
        Arun Easi <aeasi@marvell.com>
Subject: Re: [PATCH] MAINTAINERS: orphan sections with qlogic.com group
 alias
In-Reply-To: <yq1h7smkcqc.fsf@ca-mkp.ca.oracle.com>
Message-ID: <alpine.DEB.2.21.2008281745450.608@felia>
References: <20200828070824.8032-1-lukas.bulwahn@gmail.com> <20200828091758.GF54274@SPB-NB-133.local> <alpine.DEB.2.21.2008281524360.11562@felia> <yq1h7smkcqc.fsf@ca-mkp.ca.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On Fri, 28 Aug 2020, Martin K. Petersen wrote:

> 
> Lukas,
> 
> > So, if these drivers are not orphans, you can answer Thomas Gleixner's
> > original email from 2019. If you can quickly ack that patch set, I am
> > happy to do the donkey work to get this apply nicely on the current
> > master (please CC me on that response).
> 
> This is the first I hear of this since the patches weren't CC:ed to
> linux-scsi. And not all of these changes pertain to storage drivers but
> to networking so I am also not sure that mails sent to the above Storage
> alias would have ended up in the right place.
> 
> But we'll get this fixed up. Reaching out to our contacts at Marvell.
>

Thanks, Martin, it is appreciated.

Lukas
