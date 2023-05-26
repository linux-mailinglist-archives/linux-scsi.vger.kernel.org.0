Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7061A712544
	for <lists+linux-scsi@lfdr.de>; Fri, 26 May 2023 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjEZLJR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 May 2023 07:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjEZLJP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 May 2023 07:09:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F6F7
        for <linux-scsi@vger.kernel.org>; Fri, 26 May 2023 04:09:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510e419d701so1106950a12.1
        for <linux-scsi@vger.kernel.org>; Fri, 26 May 2023 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685099353; x=1687691353;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+f0WP/+N5MvUYe92/BSqybSsARXcqQ8M6AlwJr5eQc=;
        b=bEtrC/C4oxYdlVFoZ8Wt/mJ7zJTzwPXUsL94S5GOJYXs9azAYYqYVjoKqnMSGtwjRP
         jAitUgqCgVmIUzJEoPw7tfqwr0ZMgGQOGSQH6ONxyFJfLqFBje6MUZ0IogT0fV0a6Unx
         MbV9LHrpPmmeq8xz3R4R6paM/ZmR+RHn/fWa4oOpdGwwuxNkjQcqTBuAsdXMEIDRm557
         q3gs0514/I22YIpn6fvugK0Iwh05WVxaQJfJJbKwzdJ7zX+J70uwaWORqHdbnKjXRxXh
         MhEuayBTIQvEhrB8CImjPlDRY15UTuI2NEbaiBWsab+JkFKVkX5ndER5+nneAfLp94zl
         mHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685099353; x=1687691353;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+f0WP/+N5MvUYe92/BSqybSsARXcqQ8M6AlwJr5eQc=;
        b=VDOkB1N6UGygasuZBTqizU0nuImRkExH/YoVGJtZf//PnqCcw0ehYVCyQfdkO4vgRf
         AvIET50UUUZIa3xtCow/QkEwc+6yrlK+9UtldHEhgEisA6CQqvDWhSoG5UTRu45wOOg9
         p7h05TnUgySF4O/HJpWtoFrHhLp5vSz6Uwo/E3ynFbnQgsKLcjLrq+pfKx0mlxler3RI
         hmSu9C+APSjywqF+Emak4nEDlgh2EpitLbXnV2Yr9qX5PXcgVJeFVQaEsSSdh74E6HbK
         8MbSAOXL++dZ3WzeZI/CWKZgUv2+kgVIktKmXuTtzCpgF+nWdw3ESm231q82IFnDYl5Y
         fRxQ==
X-Gm-Message-State: AC+VfDz8Um3/BwpqtQ/i0IO6+aAPlhFNgR8pSIvSlmll+lFajC8adOJn
        4lkY7+HG6Ic7695ZxUZlDvjtUdsYsiohIBH1/HY=
X-Google-Smtp-Source: ACHHUZ7LsKwimMLX1HBDVi3Xe1t98CmDkZhp3GHZnDFfpsyAb5UxUcKNUrM+aSHdSbKWLlYq3sx9q+69wdSIF+/eLzA=
X-Received: by 2002:a05:6402:1a2c:b0:506:7d65:c1fb with SMTP id
 be12-20020a0564021a2c00b005067d65c1fbmr162678edb.30.1685099353227; Fri, 26
 May 2023 04:09:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a872:0:b0:215:8936:d3be with HTTP; Fri, 26 May 2023
 04:09:12 -0700 (PDT)
Reply-To: laurabr8@outlook.com
From:   Laura Brown <jeswa7m@gmail.com>
Date:   Fri, 26 May 2023 11:09:12 +0000
Message-ID: <CACGCBD60q=90=z=N4yVHPZr8ByC9fg8yzod+ftfvVb9Su8GVmQ@mail.gmail.com>
Subject: =?UTF-8?B?15nXldedINeY15XXkQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

15nXldedINeY15XXkQ0KDQrXkNeg15kg15zXldeo15Qg15HXqNeQ15XXnywg15nXpteo16rXmSDX
kNeZ16rXmiDXp9ep16gg15HXoNeV15LXoiDXnNei15nXlteR15XXnyDXlNen16jXnyDXlNee16DX
ldeXINep15wg15Mi16gg15HXqNeQ15XXnw0K16nXnCA4LjUg157Xmdec15nXldefINeT15XXnNeo
INep15nXldeX15bXqCDXnNeX16nXkdeV16DXmi4g15nXqteo15Qg157XlteQ16osINeR16LXoden
15Qg15bXlSDXkNeg15kg16jXldem15Qg16nXqtep15nXkdeVDQrXkdeh15XXk9eZ15XXqi4NCg0K
15zXldeo15Qg15HXqNeQ15XXnw0K
