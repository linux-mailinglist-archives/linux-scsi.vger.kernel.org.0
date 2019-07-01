Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516962E721
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfE2VLu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 17:11:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38929 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfE2VLt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 17:11:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so615728pgc.6
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HbBIKpJ1V87/XwhjrPhv8viXHcfTQeqI4PjBeSTg0Gw=;
        b=Ba3srmf7dzvoQQJfIF/Nc/363r3WxrkxUxwT1YX1SdakmHjJrUsGhqH349Q4UarhU2
         MnNR1ppijSniN3N2dYXoH/VQWbC/KlBv2pVrxgIo1zsJans2j1koEH7lhZNMwOTVt498
         b9oC/t55egmakJMdUNpD3fnO087XYBxrNh4fgOoedVsfyR3R7OtARZHJy1CdAoL426O0
         bnrVOTy3RZNYL04h2sYGYSeQVopdPZZiEwNmTyIKgjGy50InFP010uUQ0cS2p8Dx/Qf3
         YW2pP/9v1SEatT92/tdzFONInXTeYiQ5zR18fN8Wq8yy5PgtpDQlV86SlqHnyRyzFuJ8
         fZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HbBIKpJ1V87/XwhjrPhv8viXHcfTQeqI4PjBeSTg0Gw=;
        b=oZMeM7bq6dHNy8U4djHjeChWfn2twTQIqrvzEqS/H1ljLFFOdJKGOEGoiYMldCWfzX
         lrOpDYnPGYbE/hm5nMvZ9dd2cIcMXyVl6UWCZBti/2xEm8vVZQYhuLSghHPOdFzrv/cK
         FdZLZGzyxSaEMSkqMe28n12t42DyX4ShK1QCnCnnFIQbXmWXOyQXwGs44dSNSZUHeJ8L
         N3d04CkQgxAcIs4K1i9V9fqAIYbn1LPLSmIcmDjtLL36E08rbqIPJDK1SZnTHAoZF1p5
         ifwEmloSiTYPk01KWSXo81RYOWEB3yr3YteUd99MCerJZK5NBLZEsfEaaJ/CwC6EawlF
         vUIQ==
X-Gm-Message-State: APjAAAU9UlQS1bd5scHIWIm3YmoAgecj78sRbJLRMQ7urn334kmgr76Y
        3vMgkqToMEce5bPP07ZGIc4AoA==
X-Google-Smtp-Source: APXvYqzTnXpZgzkW6k+/y8HaHDmKbpmti34vXP5d5BqOgLp6sX6O8OvIESbX9SWawKH50J31fhg/sA==
X-Received: by 2002:a63:de53:: with SMTP id y19mr64382pgi.166.1559164308033;
        Wed, 29 May 2019 14:11:48 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x18sm712793pfj.17.2019.05.29.14.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 14:11:47 -0700 (PDT)
Date:   Wed, 29 May 2019 14:11:46 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL
In-Reply-To: <20190529062316.GA3997@infradead.org>
Message-ID: <alpine.DEB.2.21.1905291410300.242480@chino.kir.corp.google.com>
References: <20190529013540.GA20273@hari-Inspiron-1545> <20190529062316.GA3997@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 28 May 2019, Christoph Hellwig wrote:

> > wd719x_chip_init is getting called in interrupt disabled
> > mode(spin_lock_irqsave) , so we need to GFP_ATOMIC instead
> > of GFP_KERNEL.
> > 
> > Issue identified by coccicheck
> 
> I don't think request_firmware is any more happy being called under
> a spinlock.  The right fix is to not hold a spinlock over the board
> initialization.
> 

Right, and not even wd719x_chip_init() is always called in this context 
otherwise wd719x_board_found() would also need the same change.
