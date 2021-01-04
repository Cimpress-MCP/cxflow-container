# cxflow-container

A repository to build a CxFlow container and push it to AWS ECR using Gitlab pipelines.

Is it weird to give an example of using Gitlab pipelines in a Github repository?  Yes.  So why am I doing it?  Because Github is where we keep all of our world-public repositories, and consistency is important.

## Overview

This repository uses Docker in a Gitlab Pipeline to build a container and push it up to ECR, as well as fetch and push static secrets to ECR.

It uses [AKeyless](https://akeyless.io) to fetch dynamic AWS credentials to obtain the necessary AWS permissions, as well as to fetch static secrets (which it stores in AWS SSM Parameter store).  Login to AKeyless is done using JWT auth utilizing the JWT provided by Gitlab to all pipelines.

Of course you could just put an AWS access id and access key in protected Gitlab variables instead of using AKeyless for dynamic credentials, but then you have to worry about manually rotating your access credentials as needed (and credential rotation is a good idea, as well as a requirement at Cimpress).

You could also store your static secrets in Gitlab and copy them into SSM, or even just manually manage them in SSM.  However, neither of these work well if you are collaborating with other teams, because you may not be able to easily give others access to your Gitlab or AWS account.  On the other hand, it's easy to share access to specific secrets in AKeyless, and so it can act as a simple way to let others set secrets for you without having to worry about sharing them in an insecure channel.

An even better option would be to adjust the final infrastructure to fetch its data out of AKeyless directly, but ECS plays much nicer with AWS services, so I'm going with this for now.

There is a companion repository for this that builds the necessary CxFlow [infrastructure via Terraform](https://github.com/Cimpress-MCP/cxflow-ecs).

## Getting Started

The full details on how to use this and the [companion repository](https://github.com/Cimpress-MCP/cxflow-ecs) to build a working CxFlow cluster can be found in the following repository:

[CxFlow ECS Example](https://github.com/Cimpress-MCP/cxflow-ecs-example)
