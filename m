Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61B023DC3F
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Aug 2020 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgHFQrj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Aug 2020 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgHFQpH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Aug 2020 12:45:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B59C0A891E;
        Thu,  6 Aug 2020 07:59:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so13032505qki.12;
        Thu, 06 Aug 2020 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OSIY4n9u4BA5DfE/QAbCFqX+1EU+SI7GkcMuyxTZUpU=;
        b=qa+mG5KAISvLjomDAKx88uAnxDoBFnbPxWwt9sd16Ldnnf6NTA1X3pvAvqEycm2tgQ
         2cFSQMDtKgZAuL6yM3MIdZ0ubvZdW6ZgQNmUReKHCM8Cgv2MKbKjSIKQSQ4jY9z/vgb2
         W2nJAZ2rxSQx6/LZK+dKNI93ySEpowgHAGES2gqjwj+m+5lkXDl73LIyakfKmHf2bcC9
         d5dpy49e3iXW77FOzS7mB9EfgH6lM5xeOLZZMPq7K+m+VAdVXkY7vbp2P9bx+d++W4jh
         zUwUt5y/ghIMOlAvVgloP6Fa9zkp2WUuPRlvNYgVw05rLzviLodo260ujKPixtFYCWJQ
         LMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OSIY4n9u4BA5DfE/QAbCFqX+1EU+SI7GkcMuyxTZUpU=;
        b=FGB54Ad9ETP8dFgbcqqiMcTdgyijDgLZf+zHTJlfa0p8iqeTs3olfyif4H/5V5tt0W
         CI/n29FD+lQD8ZF9zPqqA7fYZRM05F9IOb2KhpujIBnbejfibw1924Y0Y3KFIBpDqc+c
         06tJZHb4PIZEgKva1Q7RCib3DKvf6rzYBvGEzOTdR+ncviJfLVYHZyXaxWAt97UMsNA3
         UG23BA2HcKt+toKBWO4PlIKyydbn75JDYlINNRiXF29/TBvFiajRd124puKM5CwsXGEK
         W6mkWG3vqZsMqSRzKwpfeIdT+f/eh7Mx92iqLGzFl62pOXISHPQQWw68hirUY76uWmhM
         xPZw==
X-Gm-Message-State: AOAM532wrD6w6gsPPaouBjqJMMf+0vOkt4kjcQ/fCvAg4NoPJ4uHpwD3
        qS1P5jN9p8yzc7RIQHn3wB4=
X-Google-Smtp-Source: ABdhPJzNW7cq60K1xZdQjUVIROpt6yNINVyPlzyHKbZ1Y+qKLiht41rtiLk/a+t5Dxaz6J59NYSs0w==
X-Received: by 2002:a37:9e09:: with SMTP id h9mr8738357qke.361.1596725943107;
        Thu, 06 Aug 2020 07:59:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2e8b])
        by smtp.gmail.com with ESMTPSA id i7sm4193602qkb.131.2020.08.06.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:59:02 -0700 (PDT)
Date:   Thu, 6 Aug 2020 10:59:01 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Muneendra Kumar M <muneendra.kumar@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
Message-ID: <20200806145901.GE4520@mtj.thefacebook.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
 <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de>
 <08b9825b-6abb-c077-ac0d-bd63f10f2ac2@broadcom.com>
 <aa595605c2f776148e03a8e5dd69168a@mail.gmail.com>
 <20200806144135.GC4520@mtj.thefacebook.com>
 <96930d0f-cb4d-94f4-9cbb-c82d2f0c3840@redhat.com>
 <20200806144804.GD4520@mtj.thefacebook.com>
 <b7fb1e9a-49c4-f639-475a-791a195be46b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7fb1e9a-49c4-f639-475a-791a195be46b@redhat.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello, Paolo.

On Thu, Aug 06, 2020 at 04:54:21PM +0200, Paolo Bonzini wrote:
> If I understand correctly, your only objection is that you'd rather not
> have it specified with a file under /sys/kernel/cgroup, and instead you
> would prefer to have it implemented as a ioctl for a magic file
> somewhere else in sysfs?  I don't think there is any precedent for this,
> and I'm not even sure where that sysfs file would be.

It just doesn't fit in the cgroupfs. I don't know where it should go for
this specific case. That's for you guys to figure out. There are multiple
precedences - e.g. how perf or bpf hooks into cgroup and others that I can't
remember off the top of my head.

Thanks.

-- 
tejun
